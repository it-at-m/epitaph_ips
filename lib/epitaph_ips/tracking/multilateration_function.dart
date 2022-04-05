import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/lma_function.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';

class MultilaterationFunction extends LMAFunction {
  late Vector distances;

  @override
  void adjustParameters(List<Beacon> beacons) {
    parameters =
        Matrix.fromRows(beacons.map((e) => e.position.toVector()).toList());
    distances = Vector.fromList(beacons.map((e) => e.distanceToUser).toList());
  }

  @override
  Vector compute(Vector v) {
    return ((parameters.mapRows((row) => (row - v).pow(2)))
                .reduceColumns((combine, vector) => combine + vector)
                .sqrt() -
            distances)
        .pow(2);
  }

  @override
  Vector computeInitialGuess(List<Beacon> beacons) {
    assert(beacons.length >= 3);

    Vector posA = beacons[0].position.toVector();
    Vector posB = beacons[1].position.toVector();
    Vector posC = beacons[2].position.toVector();
    double distA = beacons[0].distanceToUser;
    double distB = beacons[1].distanceToUser;
    double distC = beacons[2].distanceToUser;

    Vector ab = posB - posA;
    Vector ac = posC - posA;
    Vector ex = (ab) / ab.norm();
    double i = ex.dot(ac);
    Vector ey = (ac - ex * i) / ((ac - ex * i).norm());
    double d = (ab).norm();
    double j = ey.dot(ac);
    double x = (pow(distA, 2) - pow(distB, 2) + pow(d, 2)) / (2 * d);
    double y =
        (pow(distA, 2) - pow(distC, 2) + pow(i, 2) + pow(j, 2)) / (2 * j) -
            i * x / j;

    return posA + ex * x + ey * y;
  }

  @override
  Matrix computeJacobian(Vector v) {
    Matrix first = parameters.mapRows((row) => (v - row));
    Vector divisor = (first.mapRows((row) => row.pow(2)))
        .reduceColumns((combine, vector) => combine + vector)
        .sqrt();

    List<Vector> tmpSecond = [];

    for (int i = 0; i < v.length; i++) {
      tmpSecond.add(divisor);
    }

    Matrix second = Matrix.fromColumns(tmpSecond).pow(-1);
    return first.multiply(second);
  }
}
