import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

/// An abstract definition for areas. A cluster of [Coordinate] saved in [points] defines it.
/// If your area is supposed to not be enterable, set [passable] to false.
abstract class Area {
  Area({required this.points, this.passable = true}) {
    for (var element in points) {
      assert(element.z == 0.0, "Only 2D points are allowed");
    }
  }

  final List<Coordinate> points;

  final bool passable;

  /// A method which checks if a certain [point] is in the [Area]
  bool pointInArea(Coordinate point);

  Area copy();

  Map<String, dynamic> toJson();

  @override
  String toString() => 'Area(points: $points)';
}
