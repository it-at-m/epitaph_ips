import 'package:ml_linalg/linalg.dart';

///A [Point] object represents a point in a cartesian Point system for a three-dimensional space
class Point {
  Point._(this.x, this.y, this.z);

  ///Factory constructor with parameters for each dimension
  factory Point(double x, double y, [double z = 0]) {
    return Point._(x, y, z);
  }

  ///Factory constructor which reads x-y-z-values from a list
  factory Point.list(List<double> l) {
    int length = l.length;
    assert(length == 2 || length == 3, 'Point must have 2 or 3 dimensions');

    if (length == 2) {
      return Point._(l[0], l[1], 0);
    }

    return Point._(l[0], l[1], l[2]);
  }

  ///Factory constructor which reads x-y-z-values from a vector
  factory Point.vector(Vector v) {
    int length = v.length;
    assert(length == 2 || length == 3, 'Point must have 2 or 3 dimensions');

    if (length == 2) {
      return Point._(v[0], v[1], 0);
    }

    return Point._(v[0], v[1], v[2]);
  }

  ///Factory constructor which returns the origin Point
  factory Point.origin() {
    return Point._(0, 0, 0);
  }

  ///Factory constructor which reads x-y-z-values from a map
  factory Point.fromJson(Map<String, dynamic> m) {
    int length = m.length;
    assert(length == 2 || length == 3, 'Point must have 2 or 3 dimensions');

    if (length == 2) {
      return Point._(m['x'], m['y'], 0);
    }

    return Point._(m['x'], m['y'], m['z']);
  }

  final double x;
  final double y;
  final double z;

  @override
  String toString() => 'Point(x: $x, y: $y, z: $z)';

  List<double> toList() => [x, y, z];

  List<double> to2DList() => [x, y];

  Vector toVector() => Vector.fromList([x, y, z]);

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};

  ///Returns the Euclidean distance to [other]
  double distanceTo(Point other) {
    return toVector().distanceTo(other.toVector());
  }

  ///Creates a new Point object with identical x-y-z-values
  Point copy() => Point._(x, y, z);

  Point operator +(Point summand) =>
      Point.vector(toVector() + summand.toVector());

  Point operator -(Point subtrahend) =>
      Point.vector(toVector() - subtrahend.toVector());

  Point operator /(num divisor) => Point.vector(toVector() / divisor);

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return x == other.x && y == other.y && z == other.z;
    }

    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(x, y, z);
}
