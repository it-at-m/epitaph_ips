import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';

class PolygonalAreaTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    PolygonalArea area2d = PolygonalArea(points: [
      Coordinate(1, 1),
      Coordinate(2, 1),
      Coordinate(3, 4),
      Coordinate(4, 4),
      Coordinate(2, -1),
      Coordinate(2, 7),
      Coordinate(-7, 1),
      Coordinate(16, -0.5),
      Coordinate(5, 1),
      Coordinate(10, 8),
      Coordinate(7, 5),
      Coordinate(8, 5.5),
    ]);

    group("*PolygonalArea Constructor Unit Tests*", () {
      test("PolygonalArea constructor 2d", () {
        //Arrange
        List<Coordinate> expected = [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ];

        //Act and expected
        expect(
            () => PolygonalArea(points: expected), isNot(throwsAssertionError));

        PolygonalArea retrieved = PolygonalArea(points: [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ]);

        List<Coordinate> expectedHull = [
          Coordinate(1.0, 1.0, 0.0),
          Coordinate(2.0, 1.0, 0.0),
          Coordinate(4.0, 3.0, 0.0),
          Coordinate(3.0, 3.0, 0.0),
          Coordinate(1.0, 1.0, 0.0)
        ];

        expect(retrieved.points.toString(), expected.toString());
        expect(retrieved.convexHullPoints.toString(), expectedHull.toString());
      });
      test("PolygonalArea constructor 3d AssertionError", () {
        //Arrange
        List<Coordinate> expected = [
          Coordinate(1, 1, 1),
          Coordinate(2, 1, 2),
          Coordinate(3, 3, 3),
          Coordinate(4, 3, 4)
        ];

        //Act and expected
        expect(() => PolygonalArea(points: expected), throwsAssertionError);
      });
      test("PolygonalArea constructor assertion error", () {
        //Arrange
        List<Coordinate> error = [
          Coordinate(
            1,
            1,
          )
        ];

        //Act and expected
        expect(() => PolygonalArea(points: error), throwsAssertionError);

        List<Coordinate> noError = [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ];

        expect(
            () => PolygonalArea(points: noError), isNot(throwsAssertionError));
      });
      test("PolygonalArea constructor fromJson 2d", () {
        //Arrange
        Map<String, dynamic> error = {
          'points': [
            {'x': 1.0, 'y': 1.0, 'z': 0.0}
          ]
        };

        //Act and expected
        //Check for assertion
        expect(() => PolygonalArea.fromJson(error), throwsAssertionError);

        List<Coordinate> expectedValue = [
          Coordinate(1.0, 1.0),
          Coordinate(2.0, 1.0),
          Coordinate(3.0, 3.0),
          Coordinate(4.0, 3.0)
        ];

        PolygonalArea polygonalArea = PolygonalArea.fromJson({
          'points': [
            {'x': 1.0, 'y': 1.0, 'z': 0.0},
            {'x': 2.0, 'y': 1.0, 'z': 0.0},
            {'x': 3.0, 'y': 3.0, 'z': 0.0},
            {'x': 4.0, 'y': 3.0, 'z': 0.0}
          ]
        });

        for (int i = 0; i < expectedValue.length; i++) {
          expect(polygonalArea.points[i].x, expectedValue[i].x);
          expect(polygonalArea.points[i].y, expectedValue[i].y);
          expect(polygonalArea.points[i].z, expectedValue[i].z);
        }
        List<Coordinate> expectedHull = [
          Coordinate(1.0, 1.0, 0.0),
          Coordinate(2.0, 1.0, 0.0),
          Coordinate(4.0, 3.0, 0.0),
          Coordinate(3.0, 3.0, 0.0),
          Coordinate(1.0, 1.0, 0.0)
        ];

        expect(
            polygonalArea.convexHullPoints.toString(), expectedHull.toString());
      });
      group("*PolygonalArea Method Unit Tests*", () {
        test("pointInArea 2d false", () {
          //2d
          //testing for false
          bool expected = false;

          //Arrange
          Coordinate point = Coordinate(0, 6);

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
          PolygonalArea copy = area2d.copy() as PolygonalArea;
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
              {'x': 2.0, 'y': 1.0, 'z': 0.0},
              {'x': 3.0, 'y': 4.0, 'z': 0.0},
              {'x': 4.0, 'y': 4.0, 'z': 0.0},
              {'x': 2.0, 'y': -1.0, 'z': 0.0},
              {'x': 2.0, 'y': 7.0, 'z': 0.0},
              {'x': -7.0, 'y': 1.0, 'z': 0.0},
              {'x': 16.0, 'y': -0.5, 'z': 0.0},
              {'x': 5.0, 'y': 1.0, 'z': 0.0},
              {'x': 10.0, 'y': 8.0, 'z': 0.0},
              {'x': 7.0, 'y': 5.0, 'z': 0.0},
              {'x': 8.0, 'y': 5.5, 'z': 0.0}
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
              'PolygonalArea(points: [Coordinate(x: 1.0, y: 1.0, z: 0.0), Coordinate(x: 2.0, y: 1.0, z: 0.0), Coordinate(x: 3.0, y: 3.0, z: 0.0)])';

          //Act
          PolygonalArea obj = PolygonalArea(
              points: [Coordinate(1, 1), Coordinate(2, 1), Coordinate(3, 3)]);

          String retrieved = obj.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}
