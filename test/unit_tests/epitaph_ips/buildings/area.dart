import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

class AreaTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    _MockArea area2d = _MockArea([
      Coordinate(1, 1),
      Coordinate(2, 2),
      Coordinate(3, 3),
      Coordinate(4, 4)
    ]);

    group("*Area Constructor Unit Tests*", () {
      test("Area constructor 2d", () {
        //Arrange
        List<Coordinate> expected = [
          Coordinate(1, 1),
          Coordinate(2, 2),
          Coordinate(3, 3),
          Coordinate(4, 4)
        ];

        //Act and expected
        expect(() => _MockArea(expected), isNot(throwsAssertionError));

        _MockArea retrieved = _MockArea([
          Coordinate(1, 1),
          Coordinate(2, 2),
          Coordinate(3, 3),
          Coordinate(4, 4)
        ]);

        expect(retrieved.points.toString(), expected.toString());
      });
      test("Area constructor 3d Assertion Error", () {
        //Arrange
        List<Coordinate> expected = [
          Coordinate(1, 1, 1),
          Coordinate(2, 2, 2),
          Coordinate(3, 3, 3),
          Coordinate(4, 4, 4)
        ];

        //Act and expected
        expect(() => _MockArea(expected), throwsAssertionError);
      });
      group("*Area Method Unit Tests*", () {
        test("pointInArea 2d false", () {
          //2d
          //testing for false
          bool expected = false;

          //Arrange
          Coordinate point = Coordinate(1, 2);

          //expected
          expect(area2d.pointInArea(point), expected);
        });
        test("pointInArea 2d true", () {
          //2d
          //testing for true
          bool expected = true;

          //Arrange
          Coordinate point = Coordinate(1, 1);

          //expected
          expect(area2d.pointInArea(point), expected);
        });
        test("copy 2d", () {
          //Arrange
          Coordinate expected = Coordinate(1, 1);

          //Act
          _MockArea copy = area2d.copy() as _MockArea;
          Coordinate retrieved = copy.points[0];

          expect(retrieved.x, expected.x);
          expect(retrieved.y, expected.y);
          expect(retrieved.z, expected.z);
        });
        test("toJson 2d", () {
          //Arrange
          Map<String, dynamic> expectedValue = {
            'points': [
              {'x': 1.0, 'y': 1.0, 'z': 0.0},
              {'x': 2.0, 'y': 2.0, 'z': 0.0},
              {'x': 3.0, 'y': 3.0, 'z': 0.0},
              {'x': 4.0, 'y': 4.0, 'z': 0.0}
            ]
          };

          //Act
          Map<String, dynamic> retrieved = area2d.toJson();

          //expected
          expect(retrieved, expectedValue);
        });
        test("toString 2d", () {
          //Arrange
          String expectedValue =
              'Area(points: [Coordinate(x: 1.0, y: 1.0, z: 0.0), Coordinate(x: 2.0, y: 2.0, z: 0.0)])';

          //Act
          _MockArea obj = _MockArea([Coordinate(1, 1), Coordinate(2, 2)]);

          String retrieved = obj.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}

class _MockArea extends Area {
  _MockArea(List<Coordinate> points) : super(points: points);

  @override
  pointInArea(Coordinate point) {
    bool found = false;

    for (var element in points) {
      if (element.x == point.x &&
          element.y == point.y &&
          element.z == point.z) {
        found = true;
      }
    }
    return found;
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
}
