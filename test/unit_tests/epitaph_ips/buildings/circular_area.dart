import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/circular_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

class CircularAreaTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    CircularArea area2d = CircularArea(m: Point(1, 1), r: 2.0);

    group("*CircularArea Constructor Unit Tests*", () {
      test("CircularArea constructor 2d", () {
        //Arrange
        Point expectedM = Point(1, 1);
        double expectedR = 2.0;

        //Act and expected
        expect(() => CircularArea(m: expectedM, r: expectedR),
            isNot(throwsAssertionError));

        CircularArea retrieved = CircularArea(m: Point(1, 1), r: 2.0);

        expect(retrieved.m.x, expectedM.x);
        expect(retrieved.m.y, expectedM.y);
        expect(retrieved.m.z, 0);
        expect(retrieved.r, expectedR);
      });
      test("CircularArea constructor 3d Assertion Error", () {
        expect(() => CircularArea(m: Point(3, 3, 3), r: 2.0),
            throwsAssertionError);
      });
      test("CircularArea.fromPoints constructor 2d", () {
        //Arrange
        Point expectedM = Point(1, 1);
        double expectedR = 2.0;

        //Act and expected
        CircularArea retrieved =
            CircularArea.fromPoints(m: Point(1, 1), rPoint: Point(3, 1));

        expect(retrieved.m.x, expectedM.x);
        expect(retrieved.m.y, expectedM.y);
        expect(retrieved.m.z, expectedM.z);
        expect(retrieved.r, expectedR);
      });
      test("CircularArea.fromJson constructor 2d", () {
        //Arrange
        Point expectedM = Point(1, 1);
        double expectedR = 2.0;

        //Act and expected
        CircularArea retrieved = CircularArea.fromJson({
          'm': {'x': 1.0, 'y': 1.0, 'z': 0.0},
          'r': 2.0
        });

        expect(retrieved.m.x, expectedM.x);
        expect(retrieved.m.y, expectedM.y);
        expect(retrieved.m.z, expectedM.z);
        expect(retrieved.r, expectedR);
      });

      group("*CircularArea Method Unit Tests*", () {
        test("pointInArea 2d false", () {
          //2d
          //testing for false
          bool expected = false;

          //Arrange
          Point point = Point(6, 2);

          //expected
          expect(area2d.pointInArea(point), expected);
        });
        test("PointInArea 2d true", () {
          //2d
          //testing for true
          bool expected = true;

          //Arrange
          Point point = Point(1, 1);

          //expected
          expect(area2d.pointInArea(point), expected);
        });
        test("copy 2d", () {
          //Arrange
          Point expected = Point(1, 1);

          //Act
          CircularArea copy = area2d.copy() as CircularArea;
          Point retrieved = copy.points[0];

          expect(retrieved.x, expected.x);
          expect(retrieved.y, expected.y);
          expect(retrieved.z, expected.z);
        });
        test("toJson 2d", () {
          //Arrange
          Map<String, dynamic> expectedValue = {
            'm': {'x': 1.0, 'y': 1.0, 'z': 0.0},
            'r': 2.0
          };

          //Act
          Map<String, dynamic> retrieved = area2d.toJson();

          //expected
          expect(retrieved, expectedValue);
        });
        test("toString 2d", () {
          //Arrange
          String expectedValue =
              'CircularArea(m: Point(x: 1.0, y: 1.0, z: 0.0), r: 2.0)';

          //Act
          CircularArea obj = CircularArea(m: Point(1, 1), r: 2.0);

          String retrieved = obj.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}
