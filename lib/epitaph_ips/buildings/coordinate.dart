import 'package:ml_linalg/linalg.dart';

///A [Coordinate] object represents a point in a cartesian coordinate system for a three-dimensional space
class Coordinate {
  Coordinate._(this.x, this.y, this.z);

  ///Factory constructor with parameters for each dimension
  factory Coordinate(double x, double y, [double z = 0]) {
    return Coordinate._(x, y, z);
  }

  ///Factory constructor which reads x-y-z-values from a list
  factory Coordinate.list(List<double> l) {
    int length = l.length;
    assert(
        length == 2 || length == 3, 'Coordinate must have 2 or 3 dimensions');

    if (length == 2) {
      return Coordinate._(l[0], l[1], 0);
    }

    return Coordinate._(l[0], l[1], l[2]);
  }

  ///Factory constructor which reads x-y-z-values from a vector
  factory Coordinate.vector(Vector v) {
    int length = v.length;
    assert(
        length == 2 || length == 3, 'Coordinate must have 2 or 3 dimensions');

    if (length == 2) {
      return Coordinate._(v[0], v[1], 0);
    }

    return Coordinate._(v[0], v[1], v[2]);
  }

  ///Factory constructor which returns the origin coordinate
  factory Coordinate.origin() {
    return Coordinate._(0, 0, 0);
  }

  ///Factory constructor which reads x-y-z-values from a map
  factory Coordinate.fromJson(Map<String, dynamic> m) {
    int length = m.length;
    assert(
        length == 2 || length == 3, 'Coordinate must have 2 or 3 dimensions');

    if (length == 2) {
      return Coordinate._(m['x'], m['y'], 0);
    }

    return Coordinate._(m['x'], m['y'], m['z']);
  }

  final double x;
  final double y;
  final double z;

  @override
  String toString() => 'Coordinate(x: $x, y: $y, z: $z)';

  List<double> toList() => [x, y, z];

  List<double> to2DList() => [x, y];

  Vector toVector() => Vector.fromList([x, y, z]);

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};

  ///Returns the Euclidean distance to [other]
  double distanceTo(Coordinate other) {
    return toVector().distanceTo(other.toVector());
  }

  ///Creates a new Coordinate object with identical x-y-z-values
  Coordinate copy() => Coordinate._(x, y, z);

  Coordinate operator +(Coordinate summand) =>
      Coordinate.vector(toVector() + summand.toVector());

  Coordinate operator -(Coordinate subtrahend) =>
      Coordinate.vector(toVector() - subtrahend.toVector());

  Coordinate operator /(num divisor) => Coordinate.vector(toVector() / divisor);

  @override
  bool operator ==(Object other) {
    if (other is Coordinate) {
      return x == other.x && y == other.y && z == other.z;
    }

    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(x, y, z);
}
