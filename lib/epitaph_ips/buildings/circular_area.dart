import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

///A circular implementation of an [Area]. [m] is the middle point of your circle while [r] is the radius.
///If you have two points instead you can use [CircularArea.fromPoints] to generate it from two points instead.
class CircularArea extends Area {
  CircularArea({required Coordinate m, required double r})
      : super(points: [m, Coordinate(m.x, (m.y + r))]) {
    _r = r;
  }

  CircularArea.fromPoints({required Coordinate m, required Coordinate rPoint})
      : super(points: [m, rPoint]) {
    _r = m.toVector().distanceTo(rPoint.toVector());
  }

  CircularArea.fromJson(Map<String, dynamic> json)
      : super(points: [
          Coordinate.fromJson(json['m']),
          Coordinate(json['m']['x'], (json['m']['y'] + json['r']))
        ]) {
    _r = json['r'];
  }

  double _r = 0.0;

  Coordinate get m => points[0];

  double get r => _r;

  @override
  bool pointInArea(Coordinate point) => (m.distanceTo(point) < _r);

  @override
  Area copy() => this;

  @override
  Map<String, dynamic> toJson() => {'m': m.toJson(), 'r': _r};

  @override
  String toString() => 'CircularArea(m: $m, r: $r)';
}
