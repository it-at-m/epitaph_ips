import 'dart:collection';
import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

/// An implementation of a polygonal 2 dimensional [Area]. A convex hull is build from the list of [points] when an object is instantiated.
class PolygonalArea extends Area {
  PolygonalArea({required List<Point> points}) : super(points: points) {
    assert(points.length > 2, "An area needs at least 3 points");
    convexHullPoints = _convexHullGenerator(super.points);
  }

  PolygonalArea.fromJson(Map<String, dynamic> json)
      : super(points: _jsonToList(json)) {
    convexHullPoints = _convexHullGenerator(super.points);
  }

  List<Point>? convexHullPoints;

  ///A raycast checks if the [point] is inside the [convexHullPoints].
  @override
  bool pointInArea(Point point) {
    //Raycasting the convex hull
    bool inside = false;

    int iterations = convexHullPoints!.length;
    for (int i = 0; i < iterations; i++) {
      if (_intersectsWithEdge(convexHullPoints![i],
          convexHullPoints![(i + 1) % iterations], point)) {
        inside = !inside;
      }
    }

    return inside;
  }

  ///Needed for raycasts. Checks if a point [p] intersects if an edge spanning [a] and [b].
  bool _intersectsWithEdge(Point a, Point b, Point p) {
    double py = p.y;

    //recursion, if I understood this correctly it will call itself one additional time.
    if (a.y > b.y) return _intersectsWithEdge(b, a, p);

    if (p.y == a.y || p.y == b.y) py += 0.001;

    if (py > b.y || py < a.y || p.x >= max(a.x, b.x)) return false;

    if (p.x < min(a.x, b.x)) return true;

    double red = (py - a.y) / (p.x - a.x);
    double blue = (b.y - a.y) / (b.x - a.x);
    return red >= blue;
  }

  List<Point> _convexHullGenerator(List<Point> points) {
    List<Point> sorted = _sortPoints(points);

    assert(
        sorted.length > 2, 'A 2d convex hull needs at least  3 unique points');
    assert(!_collinearListCheck(points),
        'A convex hull can only be created if not every point is collinear in the list');

    Stack<Point> stack = Stack();

    stack.push(sorted[0]);
    stack.push(sorted[1]);

    for (int i = 2; i < sorted.length; i++) {
      Point head = sorted[i];
      Point middle = stack.pop();
      Point tail = stack.peek;

      _TurnTypes turn = _checkTurnType(tail, middle, head);

      switch (turn) {
        case _TurnTypes.counterClockwise:
          stack.push(middle);
          stack.push(head);
          break;
        case _TurnTypes.clockwise:
          i--;
          break;
        case _TurnTypes.collinear:
          stack.push(head);
          break;
      }
    }

    stack.push(sorted[0]);
    return stack._list;
  }

  /// Sorts points in order of their angles dependent on the lowest point the a list of [points].
  List<Point> _sortPoints(List<Point> points) {
    final Point starting = _lowestPoint(points);

    SplayTreeSet<Point> sorted = SplayTreeSet((Point a, Point b) {
      if (a == b) return 0;
      double thetaA = atan2(a.y - starting.y, a.x - starting.x);
      double thetaB = atan2(b.y - starting.y, b.x - starting.x);

      if (thetaA < thetaB) {
        return -1;
      } else if (thetaA > thetaB) {
        return 1;
      } else {
        double distanceA = starting.distanceTo(a);
        double distanceB = starting.distanceTo(b);

        if (distanceA < distanceB) {
          return -1;
        } else {
          return 1;
        }
      }
    });

    sorted.addAll(points);

    return sorted.toList();
  }

  /// Min y point of [points]
  Point _lowestPoint(List<Point> points) {
    Point lowest = points[0];

    for (int i = 1; i < points.length; i++) {
      Point current = points[i];
      if (current.y < lowest.y ||
          (current.y == lowest.y && current.x < lowest.x)) {
        lowest = current;
      }
    }
    return lowest;
  }

  /// Returns true if every point in [points] List is collinear to each other.
  bool _collinearListCheck(List<Point> points) {
    if (points.length < 2) return true;

    Point a = points[0];
    Point b = points[1];

    for (int i = 2; i < points.length; i++) {
      Point c = points[i];
      if (_checkTurnType(a, b, c) != _TurnTypes.collinear) return false;
    }
    return true;
  }

  /// Uses trigonometry to determine in which direction a collection of three points turn.
  _TurnTypes _checkTurnType(Point a, Point b, Point c) {
    double crossProduct =
        ((b.x - a.x) * (c.y - a.y)) - ((b.y - a.y) * (c.x - a.x));

    if (crossProduct > 0) {
      return _TurnTypes.counterClockwise;
    } else if (crossProduct < 0) {
      return _TurnTypes.clockwise;
    } else {
      return _TurnTypes.collinear;
    }
  }

  @override
  Area copy() => this;

  @override
  Map<String, dynamic> toJson() {
    // Lists cannot be automatically be generated, this is why this method is convoluted
    List<dynamic> pointsList = [];
    for (var element in super.points) {
      pointsList.add(element.toJson());
    }

    return {'points': pointsList};
  }

  @override
  String toString() => 'PolygonalArea(points: $points)';
}

// Makes it possible to load from JSON
List<Point> _jsonToList(Map<String, dynamic> json) {
  List<Point> pointsList = [];
  json['points'].forEach((element) {
    pointsList.add(Point.fromJson(element));
  });

  return pointsList;
}

/// A list of possible types of turns direction wise.
enum _TurnTypes { clockwise, counterClockwise, collinear }

///An implementation of a classic Stack
class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
