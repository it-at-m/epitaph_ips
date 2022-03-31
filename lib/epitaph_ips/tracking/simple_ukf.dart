import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/sigma_point_function.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/matrix_helpers.dart';
import 'package:ml_linalg/linalg.dart';

/// A lot of magic happens here but the implementation should be robust enough
/// to confidently ignore this file when looking for bugs.
///
/// Note: This is a simple implementation leaned on the full implementation of FilterPy's UKF

class SimpleUKF extends Filter {
  SimpleUKF._(
      this.x,
      this.p,
      this._dt,
      this._hx,
      this._fx,
      this._sigmaFn,
      this._q,
      this.r,
      this._weightsMean,
      this._weightsCov,
      this._sigmasF,
      this._sigmasH,
      this._k,
      this._y,
      this._s,
      this._sInverted,
      this._dimX,
      this._dimZ,
      this._numSigmas);

  factory SimpleUKF(int dimX, int dimZ, double dt, Function hx, Function fx,
      SigmaPointFunction sigmaFn, int numSigmas,
      {Function? xMeanFn, Function? zMeanFn}) {
    Matrix x = filledWithZeros(1, columns: dimX);
    Matrix p = Matrix.identity(dimX);
    Matrix q = Matrix.identity(dimX);
    Matrix r = Matrix.identity(dimZ);
    Matrix weightsMean = sigmaFn.weightsMean;
    Matrix weightsCov = sigmaFn.weightsCov;
    Matrix sigmasF = filledWithZeros(numSigmas, columns: dimX);
    Matrix sigmasH = filledWithZeros(numSigmas, columns: dimZ);
    Matrix k = filledWithZeros(dimZ, columns: dimX);
    Matrix y = filledWithZeros(1, columns: dimZ).transpose();
    Matrix z = Matrix.fromRows([Vector.randomFilled(dimZ)]);
    Matrix s = filledWithZeros(dimZ);
    return SimpleUKF._(x, p, dt, hx, fx, sigmaFn, q, r, weightsMean, weightsCov,
        sigmasF, sigmasH, k, y, z, s, dimX, dimZ, numSigmas);
  }

  int _dimX;
  int _dimZ;
  int _numSigmas;
  double _dt;
  SigmaPointFunction _sigmaFn;
  Function _hx;
  Function _fx;
  Matrix x;
  Matrix p;
  Matrix r;
  Matrix _q;
  Matrix _k;
  Matrix _y;
  Matrix _sigmasF;
  Matrix? _sigmasH;
  Matrix _s;
  Matrix _sInverted;
  Matrix _weightsMean;
  Matrix _weightsCov;

  set q(Matrix value) {
    _q = value;
  }

  /// Predict function of the Kalman Filter
  void predict({List? args}) {
    double? dt = _dt;
    computeProcessSigmas(dt, args);
    List tmp =
        unscentedTransform(_sigmasF, _weightsMean, _weightsCov, noiseCov: _q);
    x = tmp[0];
    p = tmp[1];
    _sigmasF = _sigmaFn.computeSigmaPoints(x, p);
  }

  /// Update function of the Kalman Filter
  void update(Matrix? z, {List? args}) {
    if (z == null) {
      return;
    }

    List<List<double>> sigmasH = [];
    for (var element in _sigmasF) {
      sigmasH.add(_hx(Matrix.row(element.toList()), args)[0].toList());
    }

    _sigmasH = atLeast2D(Matrix.fromList(sigmasH));
    List<Matrix> ut =
        unscentedTransform(_sigmasH!, _weightsMean, _weightsCov, noiseCov: r);
    Matrix zp = ut[0];
    _s = ut[1];
    _sInverted = toInverse(_s);
    Matrix pxz = _crossVariance(x, zp, _sigmasF, _sigmasH!);
    _k = pxz * _sInverted;
    _y = z - zp;
    x = x + (_k * _y.toVector()).transpose();
    p = p - (_k * (_s * _k.transpose()));
  }

  List<Matrix> unscentedTransform(
      Matrix sigmas, Matrix weightsM, Matrix weightsC,
      {Matrix? noiseCov}) {
    Matrix newP = filledWithZeros(sigmas.columnsNum);
    Matrix newX = weightsM * sigmas;
    Matrix newY = sigmas
        .mapRows((row) => row - newX.toVector()); // sigmas - x.toVector();
    newP = newY.transpose() * (Matrix.diagonal(weightsC[0].toList()) * newY);

    if (noiseCov != null) {
      if (noiseCov.length == 1) {
        newP = newP + noiseCov[0][0];
      } else {
        newP = newP + noiseCov;
      }
    }

    return [newX, newP];
  }

  void computeProcessSigmas(double? dt, [List? args]) {
    Matrix sigmas = _sigmaFn.computeSigmaPoints(x, p);
    List<List<double>> tmp = [];

    for (int i = 0; i < sigmas.rowsNum; i++) {
      Matrix fx = _fx(Matrix.fromColumns([sigmas[i]]), dt, args);
      tmp.add(fx.transpose()[0].toList());
    }

    _sigmasF = Matrix.fromList(tmp);
  }

  Matrix _crossVariance(Matrix x, Matrix z, Matrix sigmasF, Matrix sigmasH) {
    Matrix pxz =
        filledWithZeros(sigmasF.columnsNum, columns: sigmasH.columnsNum);
    int n = sigmasF.rowsNum;

    for (int i = 0; i < n; i++) {
      Matrix dx = Matrix.fromRows(
          [sigmasF[i] - x]); //sigmasF - broadcast(x, sigmasF.rowsNum);
      Matrix dz = Matrix.fromRows(
          [sigmasH[i] - z]); //sigmasH - broadcast(z, sigmasH.rowsNum);
      pxz = pxz + outer(dx, dz) * _weightsCov[0][i];
    }

    return pxz;
  }

  Matrix calculateQWhiteNoise(
      int dim, double dt, double variable, int blockSize, bool orderByDim) {
    List<Vector> q = [];
    assert(dim > 1 && dim < 5);

    if (dim == 2) {
      q.add(Vector.fromList([0.25 * pow(dt, 4), 0.5 * pow(dt, 3)]));
      q.add(Vector.fromList([0.5 * pow(dt, 3), pow(dt, 2)]));
    } else if (dim == 3) {
      q.add(Vector.fromList(
          [0.25 * pow(dt, 4), 0.5 * pow(dt, 3), 0.5 * pow(dt, 2)]));
      q.add(Vector.fromList([0.5 * pow(dt, 3), pow(dt, 2), dt]));
      q.add(Vector.fromList([0.5 * pow(dt, 2), dt, 1]));
    } else {
      q.add(Vector.fromList(
          [pow(dt, 6) / 36, pow(dt, 5) / 12, pow(dt, 4) / 6, pow(dt, 3) / 6]));
      q.add(Vector.fromList(
          [pow(dt, 5) / 12, pow(dt, 4) / 4, pow(dt, 3) / 2, pow(dt, 2) / 2]));
      q.add(Vector.fromList([pow(dt, 4) / 6, pow(dt, 3) / 2, pow(dt, 2), dt]));
      q.add(Vector.fromList([pow(dt, 3) / 6, pow(dt, 2) / 2, dt, 1]));
    }

    if (orderByDim) {
      List qList = [];
      for (int i = 0; i < blockSize; i++) {
        qList.add(q);
      }

      return blockDiag(qList) * variable;
    } else {
      return orderByDerivative(Matrix.fromRows(q), dim, blockSize) * variable;
    }
  }

  @override
  void configFilter(Coordinate initialPosition) {
    x = Matrix.fromList([
      [initialPosition.x, 0, initialPosition.y, 0]
    ]);
  }

  @override
  Coordinate filter(Coordinate newPosition,
      {List? predictArgs, Matrix? z, List? updateArgs}) {
    predict(args: predictArgs);
    update(Matrix.row(newPosition.to2DList()), args: updateArgs);
    return Coordinate(x.elementAt(0).first, x.elementAt(0).toList()[2]);
  }

  @override
  void reset() {
    x = filledWithZeros(1, columns: _dimX);
    p = Matrix.identity(_dimX);
    q = Matrix.identity(_dimX);
    r = Matrix.identity(_dimX);
    _sigmasF = filledWithZeros(_numSigmas, columns: _dimX);
    _sigmasH = filledWithZeros(_numSigmas, columns: _dimZ);
    _k = filledWithZeros(_dimZ, columns: _dimX);
    _y = filledWithZeros(1, columns: _dimZ).transpose();
    _s = filledWithZeros(_dimZ);
  }
}
