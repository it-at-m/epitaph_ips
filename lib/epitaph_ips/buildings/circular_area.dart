import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

///A circular implementation of an [Area]. [m] is the middle point of your circle while [r] is the radius.
///If you have two points instead you can use [CircularArea.fromPoints] to generate it from two points instead.
class CircularArea extends Area {
  CircularArea({required Point m, required double r})
      : super(points: [m, Point(m.x, (m.y + r))]) {
    _r = r;
  }

  CircularArea.fromPoints({required Point m, required Point rPoint})
      : super(points: [m, rPoint]) {
    _r = m.toVector().distanceTo(rPoint.toVector());
  }

  CircularArea.fromJson(Map<String, dynamic> json)
      : super(points: [
          Point.fromJson(json['m']),
          Point(json['m']['x'], (json['m']['y'] + json['r']))
        ]) {
    _r = json['r'];
  }

  double _r = 0.0;

  Point get m => points[0];

  double get r => _r;

  @override
  bool pointInArea(Point point) => (m.distanceTo(point) < _r);

  @override
  Area copy() => this;

  @override
  Map<String, dynamic> toJson() => {'m': m.toJson(), 'r': _r};

  @override
  String toString() => 'CircularArea(m: $m, r: $r)';
}
