import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:ml_linalg/linalg.dart';

class CoordinateTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*UnitTestCoordinate getter Unit Tests*", () {
      test("get x-y-z-values", () {
        //Arrange
        double expectedX = 36.0;
        double expectedY = 6.4;
        double expectedZ = 117.0;

        Coordinate coordinate = Coordinate(expectedX, expectedY, expectedZ);

        //Act
        double retrievedX = coordinate.x;
        double retrievedY = coordinate.y;
        double retrievedZ = coordinate.z;

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
        Coordinate coordinate = Coordinate(expectedX, expectedY, expectedZ);
        double retrievedX = coordinate.x;
        double retrievedY = coordinate.y;
        double retrievedZ = coordinate.z;

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
        Vector vector = Coordinate(expectedX, expectedY, expectedZ).toVector();
        double retrievedX = vector.elementAt(0);
        double retrievedY = vector.elementAt(1);
        double retrievedZ = vector.elementAt(2);

        //expect
        expect(expectedX, retrievedX);
        expect(expectedY, retrievedY);
        expect(expectedZ, retrievedZ);
      });
    });
    group("*UnitTestCoordinate Method Unit Tests*", () {
      test('equality of factories', () {
        double x = 1;
        double y = 1;
        double z = 7;
        List<double> l = [x, y, z];
        Vector v = Vector.fromList([x, y, z]);
        Map<String, dynamic> m = {'x': x, 'y': y, 'z': z};
        Coordinate parameters = Coordinate(x, y, z);
        Coordinate list = Coordinate.list(l);
        Coordinate vector = Coordinate.vector(v);
        Coordinate json = Coordinate.fromJson(m);
        expect(parameters.toString(), list.toString());
        expect(list.toString(), vector.toString());
        expect(vector.toString(), json.toString());
      });
      test('assertion tests', () {
        expect(() => Coordinate.list([117]), throwsAssertionError);
        expect(() => Coordinate.list([0, 1, 1, 7]), throwsAssertionError);
        expect(() => Coordinate.vector(Vector.fromList([117])),
            throwsAssertionError);
        expect(() => Coordinate.vector(Vector.fromList([0, 1, 1, 7])),
            throwsAssertionError);
        expect(() => Coordinate.fromJson({'x': 117}), throwsAssertionError);
        expect(() => Coordinate.fromJson({'w': 0, 'x': 1, 'y': 1, 'z': 7}),
            throwsAssertionError);
      });
      test("distanceTo self coordinate zero", () {
        //Arrange
        double expectedDistance = 0;

        double x = 3.0;
        double y = -1.2;

        Coordinate coordinate = Coordinate(x, y);

        //Act
        double retrievedDistance = coordinate.distanceTo(coordinate);

        //expect
        expect(expectedDistance, retrievedDistance);
      });
      test("distanceTo other coordinate", () {
        //Arrange
        double expectedDistance = 5.199999721233654;

        double x = 3.0;
        double y = -1.2;

        Coordinate coordinate = Coordinate(x, y);

        //Act
        double retrievedDistance = coordinate.distanceTo(Coordinate(3, 4));

        //expect
        expect(expectedDistance, retrievedDistance);
      });
      test("toList coordinate", () {
        //Arrange
        List<double> expected = [-0.20000000298023224, -1, -117];

        //Act
        List<double> retrieved =
            Coordinate(-0.20000000298023224, -1, -117).toList();

        //expect
        expect(expected, retrieved);
      });
      test("toVector coordinate", () {
        //Arrange
        Vector expected = Vector.fromList([-0.20000000298023224, -1, -117]);

        //Act
        Vector retrieved =
            Coordinate(-0.20000000298023224, -1, -117).toVector();

        //expect
        expect(expected, retrieved);
      });
      test('toJson coordinate', () {
        //Arrange
        Map<String, dynamic> expected = {
          'x': -0.20000000298023224,
          'y': -1,
          'z': -117
        };

        //Act
        Map<String, dynamic> retrieved =
            Coordinate(-0.20000000298023224, -1, -117).toJson();

        //expect
        expect(expected, retrieved);
      });
      test("operator + add coordinate", () {
        //Arrange
        Coordinate expectedSum = Coordinate(5.0, 1.7999999523162842);

        double x = 3.0;
        double y = -1.2;
        Coordinate coordinate = Coordinate(x, y);

        //Act
        Coordinate retrievedSum = coordinate + Coordinate(2, 3);

        //expect
        expect(retrievedSum.toString(), expectedSum.toString());
      });
      test("operator - subtract coordinate", () {
        //Arrange
        Coordinate expectedSum = Coordinate(1.0, -4.199999809265137);

        double x = 3.0;
        double y = -1.2;
        Coordinate coordinate = Coordinate(x, y);

        //Act
        Coordinate retrievedSum = coordinate - Coordinate(2, 3);

        //expect
        expect(retrievedSum.toString(), expectedSum.toString());
      });
      test("toString coordinate", () {
        //Arrange
        String expectedString = "Coordinate(x: 5.0, y: 4.3, z: 0.0)";

        double x = 5.0;
        double y = 4.3;
        Coordinate coordinate = Coordinate(x, y);

        //Act
        String retrievedString = coordinate.toString();

        //expect
        expect(retrievedString.toString(), expectedString.toString());
      });
    });
  }
}
