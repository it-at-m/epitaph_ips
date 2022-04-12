import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/lma_function.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/multilateration_function.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';
import 'calculator.dart';
import 'matrix_helpers.dart';

///Levenberg-Marquardt-Algorithm
class LMA extends Calculator {
  LMA._(this._initialLambda, this._maxIterations, this._ftol, this._gtol,
      this._function)
      : assert(_initialLambda >= 0, '_initialLambda must be greater equal 0'),
        assert(_maxIterations > 0, '_maxIterations must be greater 0'),
        assert(_ftol >= 0, '_ftol must be greater equal 0'),
        assert(_gtol >= 0, '_gtol must be greater equal 0');

  factory LMA(
      {double initialLambda = 1,
      int maxIterations = 100,
      double ftol = 1e-12,
      double gtol = 1e-12,
      LMAFunction? function}) {
    return LMA._(initialLambda, maxIterations, ftol, gtol,
        function ?? MultilaterationFunction());
  }

  // Convergence criteria
  final int _maxIterations;
  final double _ftol;
  final double _gtol;

  /// Dampening. Larger values means it's more like gradient descent
  final double _initialLambda;

  /// Associated initial cost
  double _initialCost = 0;

  /// Associated final cost
  double _finalCost = 0;

  /// The function that is optimized; in this case a trilateration derivative
  LMAFunction _function;

  /// Gradient
  Matrix _gradient = Matrix.empty();

  /// Hessian
  Matrix _hessian = Matrix.empty();

  Matrix _negativeStep = Matrix.empty();

  /// Result of residual functions
  Vector _residuals = Vector.empty();

  /// Jacobian
  Matrix _jacobian = Matrix.empty();

  int get maxIterations => _maxIterations;

  double get ftol => _ftol;

  double get gtol => _gtol;

  double get initialLambda => _initialLambda;

  double get initialCost => _initialCost;

  double get finalCost => _finalCost;

  Matrix get gradient => _gradient;

  Matrix get hessian => _hessian;

  Matrix get negativeStep => _negativeStep;

  Vector get residuals => _residuals;

  Matrix get jacobian => _jacobian;

  /// gradient = J'*(f(x)-y)
  /// Hessian = J'*J
  void _computeGradientAndHessian(Vector parameters) {
    _residuals = _function.compute(parameters);
    _jacobian = _function.computeJacobian(parameters);
    Matrix jacobianT = _jacobian.transpose();
    _gradient = jacobianT * _residuals;
    _hessian = jacobianT * _jacobian;
  }

  /// Computes the cost for the given parameters
  /// cost = (1/N) Sum (f(x) - y)^2
  double _calculateCost(Vector parameters) {
    _residuals = _function.compute(parameters);
    double error = _residuals.norm();
    return error * error / _residuals.length;
  }

  void reset() {
    _initialCost = 0;
    _finalCost = 0;
    _gradient = Matrix.empty();
    _hessian = Matrix.empty();
    _jacobian = Matrix.empty();
    _negativeStep = Matrix.empty();
    _residuals = Vector.empty();
  }

  @override
  Point calculate(List<Beacon> beacons) {
    _function.adjustParameters(beacons);
    Vector initialGuess = _function.computeInitialGuess(beacons);

    _jacobian = reshape(
        _jacobian,
        List.filled(
            _function.numFunctions(), List.filled(initialGuess.length, 0)));
    _initialCost = _calculateCost(initialGuess);
    double previousCost = _initialCost;
    double lambda = _initialLambda;

    /// Recompute the Jacobian in this iteration or not
    bool computeHessian = true;
    Vector optimized = Vector.fromList(initialGuess.toList());

    for (int i = 0; i < _maxIterations; i++) {
      if (computeHessian) {
        //  Compute some variables based on the gradient
        _computeGradientAndHessian(optimized);
        computeHessian = false;
        Matrix gTest =
            _gradient.mapElements((element) => element.abs() > _gtol ? 1 : 0);
        bool converged = gTest.sum() == 0;

        if (converged) {
          _finalCost = previousCost;
          return Point.vector(optimized);
        }
      }

      Matrix lambdaIdentity =
          Matrix.diagonal(Vector.filled(_hessian.columnsNum, lambda).toList());
      _hessian = _hessian + lambdaIdentity;

      /// in some cases h can be a singular matrix, meaning its determinant equals 0
      /// and the equation cannot be solved "conventionally"
      /// Premature but usable return of [parameters]
      try {
        _negativeStep = Matrix.fromList(
            matrixSolve(matrixToList(_hessian), matrixToList(_gradient)));
      } catch (error) {
        return Point.vector(optimized);
      }

      // compute the candidate parameters
      Vector candidate = optimized - _negativeStep;
      double cost = _calculateCost(candidate);

      //  if the candidate parameters produced better results, use them instead
      if (cost <= previousCost) {
        computeHessian = true;
        optimized = Vector.fromList(candidate.toList());

        // check for convergence
        // ftol <= (cost(k) - cost(k+1))/cost(k)
        bool converged = _ftol * previousCost >= previousCost - cost;
        previousCost = cost;
        lambda /= 10.0;

        if (converged) {
          _finalCost = previousCost;
          Point.vector(optimized);
        }
      } else {
        lambda *= 10.0;
      }
    }

    _finalCost = previousCost;
    return Point.vector(optimized);
  }
}
