import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';

///Abstract class for a to-be-optimized function.
abstract class LMAFunction {
  late Matrix parameters;

  void adjustParameters(List<Beacon> beacons);

  ///Computes the values of the function using the content of [v] as parameters
  Vector compute(Vector v);

  Vector computeInitialGuess(List<Beacon> beacons);

  ///Computes the Jacobian matrix using the content of [v] as parameters
  Matrix computeJacobian(Vector v);

  ///Returns the number of instances of this function
  int numFunctions() => parameters.rowsNum;
}
