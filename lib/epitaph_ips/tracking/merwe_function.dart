import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/tracking/sigma_point_function.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/matrix_helpers.dart';

///van Merwe approach to compute Sigma Points
class MerweFunction extends SigmaPointFunction {
  MerweFunction._(int n, this._alpha, this._beta, this._kappa) : super(n) {
    computeWeights();
  }

  factory MerweFunction(int n, double alpha, double beta,
      [double kappa = 0.0]) {
    return MerweFunction._(n, alpha, beta, kappa);
  }

  ///Alpha parameter
  double _alpha;

  ///Beta parameter
  double _beta;

  ///Kappa parameter
  double _kappa;

  @override
  int numberOfSigmaPoints() {
    return 2 * n + 1;
  }

  @override
  Matrix computeSigmaPoints(Matrix x, var p) {
    assert(n == x.rowsNum * x.columnsNum);

    Matrix tmp;
    int newN = n;

    if (x is num) {
      x = Matrix.fromList([
        [x as double]
      ]);
    }

    if (p is num) {
      tmp = Matrix.identity(newN) * p;
    } else {
      tmp = atLeast2D(p);
    }

    double lambda = (pow(_alpha, 2) * (newN + _kappa)) - newN;
    tmp = tmp * (lambda + newN);
    List<List<double>> test = matrixToList(tmp);

    Matrix u = Matrix.fromList(choleskyDecomposition(test)).transpose();

    List<List<double>> output =
        List.generate(2 * newN + 1, (i) => List.generate(newN, (j) => 0));
    output[0] = x[0].toList();

    for (int i = 0; i < newN; i++) {
      output[i + 1] = (x[0] + u[i]).toList();
      output[newN + i + 1] = (x[0] - u[i]).toList();
    }

    return Matrix.fromList(output);
  }

  @override
  void computeWeights() {
    int newN = n;
    double lambda = pow(_alpha, 2) * (newN + _kappa) - newN;
    double c = 0.5 / (newN + lambda);
    List<double> wc = List.generate(2 * newN + 1, (index) => c);
    List<double> wm = List.generate(2 * newN + 1, (index) => c);
    wc[0] = lambda / (newN + lambda) + (1 - pow(_alpha, 2) + _beta);
    wm[0] = lambda / (newN + lambda);
    weightsCov = Matrix.fromList([wc]);
    weightsMean = Matrix.fromList([wm]);
  }
}
