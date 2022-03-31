import 'package:ml_linalg/linalg.dart';

///General abstract class for more specific Sigma Point function implementations
abstract class SigmaPointFunction {
  SigmaPointFunction(this.n);

  ///Number of points to base the calculation of Sigma Points on
  final int n;

  ///Covariance matrix
  late Matrix _weightsCov;

  ///Mean matrix
  late Matrix _weightsMean;

  Matrix get weightsCov => _weightsCov;

  Matrix get weightsMean => _weightsMean;

  set weightsCov(value) {
    _weightsCov = value;
  }

  set weightsMean(value) {
    _weightsMean = value;
  }

  ///Returns the number of Sigma Points the function calculates
  int numberOfSigmaPoints();

  ///Computes Sigma Points and returns it in matrix form
  Matrix computeSigmaPoints(Matrix x, var p);

  ///Computes covariance and mean matrices
  void computeWeights();
}
