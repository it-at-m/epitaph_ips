import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:ml_linalg/linalg.dart';

class PointTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*UnitTestPoint getter Unit Tests*", () {
      test("get x-y-z-values", () {
        //Arrange
        double expectedX = 36.0;
        double expectedY = 6.4;
        double expectedZ = 117.0;

        Point point = Point(expectedX, expectedY, expectedZ);

        //Act
        double retrievedX = point.x;
        double retrievedY = point.y;
        double retrievedZ = point.z;

        //expect
        expect(expectedX, retrievedX);
        expect(expectedY, retrievedY);
        expect(expectedZ, retrievedZ);
      });
      test("get negative x-y-z-values", () {
        //Arrange
        double expectedX = -1.7;
        double expectedY = -2.6;
        double expectedZ = -117;

        //Act
        Point point = Point(expectedX, expectedY, expectedZ);
        double retrievedX = point.x;
        double retrievedY = point.y;
        double retrievedZ = point.z;

        //expect
        expect(expectedX, retrievedX);
        expect(expectedY, retrievedY);
        expect(expectedZ, retrievedZ);
      });
      test("get x-y-z-values with vector", () {
        //Arrange
        double expectedX =
            2.5999999046325684; //vector decimals have deviating precision
        double expectedY = 3;
        double expectedZ = 117;

        //Act
        Vector vector = Point(expectedX, expectedY, expectedZ).toVector();
        double retrievedX = vector.elementAt(0);
        double retrievedY = vector.elementAt(1);
        double retrievedZ = vector.elementAt(2);

        //expect
        expect(expectedX, retrievedX);
        expect(expectedY, retrievedY);
        expect(expectedZ, retrievedZ);
      });
    });
    group("*UnitTestPoint Method Unit Tests*", () {
      test('equality of factories', () {
        double x = 1;
        double y = 1;
        double z = 7;
        List<double> l = [x, y, z];
        Vector v = Vector.fromList([x, y, z]);
        Map<String, dynamic> m = {'x': x, 'y': y, 'z': z};
        Point parameters = Point(x, y, z);
        Point list = Point.list(l);
        Point vector = Point.vector(v);
        Point json = Point.fromJson(m);
        expect(parameters.toString(), list.toString());
        expect(list.toString(), vector.toString());
        expect(vector.toString(), json.toString());
      });
      test('assertion tests', () {
        expect(() => Point.list([117]), throwsAssertionError);
        expect(() => Point.list([0, 1, 1, 7]), throwsAssertionError);
        expect(
            () => Point.vector(Vector.fromList([117])), throwsAssertionError);
        expect(() => Point.vector(Vector.fromList([0, 1, 1, 7])),
            throwsAssertionError);
        expect(() => Point.fromJson({'x': 117}), throwsAssertionError);
        expect(() => Point.fromJson({'w': 0, 'x': 1, 'y': 1, 'z': 7}),
            throwsAssertionError);
      });
      test("distanceTo self Point zero", () {
        //Arrange
        double expectedDistance = 0;

        double x = 3.0;
        double y = -1.2;

        Point point = Point(x, y);

        //Act
        double retrievedDistance = point.distanceTo(point);

        //expect
        expect(expectedDistance, retrievedDistance);
      });
      test("distanceTo other Point", () {
        //Arrange
        double expectedDistance = 5.199999721233654;

        double x = 3.0;
        double y = -1.2;

        Point point = Point(x, y);

        //Act
        double retrievedDistance = point.distanceTo(Point(3, 4));

        //expect
        expect(expectedDistance, retrievedDistance);
      });
      test("toList Point", () {
        //Arrange
        List<double> expected = [-0.20000000298023224, -1, -117];

        //Act
        List<double> retrieved = Point(-0.20000000298023224, -1, -117).toList();

        //expect
        expect(expected, retrieved);
      });
      test("toVector Point", () {
        //Arrange
        Vector expected = Vector.fromList([-0.20000000298023224, -1, -117]);

        //Act
        Vector retrieved = Point(-0.20000000298023224, -1, -117).toVector();

        //expect
        expect(expected, retrieved);
      });
      test('toJson Point', () {
        //Arrange
        Map<String, dynamic> expected = {
          'x': -0.20000000298023224,
          'y': -1,
          'z': -117
        };

        //Act
        Map<String, dynamic> retrieved =
            Point(-0.20000000298023224, -1, -117).toJson();

        //expect
        expect(expected, retrieved);
      });
      test("operator + add Point", () {
        //Arrange
        Point expectedSum = Point(5.0, 1.7999999523162842);

        double x = 3.0;
        double y = -1.2;
        Point point = Point(x, y);

        //Act
        Point retrievedSum = point + Point(2, 3);

        //expect
        expect(retrievedSum.toString(), expectedSum.toString());
      });
      test("operator - subtract Point", () {
        //Arrange
        Point expectedSum = Point(1.0, -4.199999809265137);

        double x = 3.0;
        double y = -1.2;
        Point point = Point(x, y);

        //Act
        Point retrievedSum = point - Point(2, 3);

        //expect
        expect(retrievedSum.toString(), expectedSum.toString());
      });
      test("toString Point", () {
        //Arrange
        String expectedString = "Point(x: 5.0, y: 4.3, z: 0.0)";

        double x = 5.0;
        double y = 4.3;
        Point point = Point(x, y);

        //Act
        String retrievedString = point.toString();

        //expect
        expect(retrievedString.toString(), expectedString.toString());
      });
    });
  }
}
