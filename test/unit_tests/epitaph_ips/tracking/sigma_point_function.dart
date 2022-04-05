import 'package:flutter_test/flutter_test.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/sigma_point_function.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/merwe_function.dart';

class SigmaPointFunctionTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*UnitTestSigmaPoints Unit Tests*", () {
      test("sigma numberOfSigmaPoints test", () {
        //arrange
        int expectedValue = 5;

        //act
        MerweFunction sigma = MerweFunction(2, 0.1, 2.0, -1);

        int retrievedValue = sigma.numberOfSigmaPoints();

        //expect
        expect(retrievedValue, expectedValue);
      });
      test("sigma numberOfSigmaPoints zero test", () {
        //arrange
        int expectedValue = 1;

        //act
        SigmaPointFunction sigma = MerweFunction(0, 0.0, 0.0, 0);

        int retrievedValue = sigma.numberOfSigmaPoints();

        //expect
        expect(retrievedValue, expectedValue);
      });
      test("sigma computeSigmaPoints test", () {
        //arrange
        final expectedMatrix = Matrix.fromList([
          [2.0, 2.0],
          [2.141421318054199, 2.0],
          [2.0, 2.141421318054199],
          [1.8585786819458008, 2.0],
          [2.0, 1.8585786819458008]
        ]);

        final matrix = Matrix.fromList([
          [2.0, 2.0],
        ]);

        //act
        SigmaPointFunction sigma = MerweFunction(2, 0.1, 2.0, -1);

        Matrix retrievedValue = sigma.computeSigmaPoints(matrix, 2);

        //expect
        expect(retrievedValue, expectedMatrix);
      });
      test("sigma computeSigmaPoints set p to zero test", () {
        //arrange
        final expectedMatrix = Matrix.fromList([
          [2.0, 2.0],
          [2.0, double.nan],
          [2.0, double.nan],
          [2.0, double.nan],
          [2.0, double.nan]
        ]);

        final matrix = Matrix.fromList([
          [2.0, 2.0],
        ]);

        //act
        SigmaPointFunction sigma = MerweFunction(2, 0.1, 2.0, -1);

        Matrix retrievedValue = sigma.computeSigmaPoints(
            matrix, 0); //returns double NaN values, it this a bug?

        //expect
        expect(retrievedValue.toString(), expectedMatrix.toString());
      });
      test("sigma computeSigmaPoints n assertion test", () {
        //arrange
        final matrix = Matrix.fromList([
          [2.0, 2.0],
        ]);

        //act
        SigmaPointFunction sigma = MerweFunction(3, 0.1, 2.0, -1);

        //act and expect
        expect(() => sigma.computeSigmaPoints(matrix, 2), throwsAssertionError);
      });
    });
  }
}
