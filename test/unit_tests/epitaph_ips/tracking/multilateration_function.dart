import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/multilateration_function.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';

class MultilaterationFunctionTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*LMAFunction Method Unit Tests*', () {
      test('compute test', () {
        //Arrange
        Matrix parameters = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        Vector distances = Vector.fromList([0.5, 0.5, 0.5]);
        Vector input = Vector.fromList([2.0, 1.0]);
        Vector expected = Vector.fromList([0.25, 0.25, 0.25]);

        //Act
        MultilaterationFunction testFunction = MultilaterationFunction();
        testFunction.distances = distances;
        testFunction.parameters = parameters;
        Vector retrieved = testFunction.compute(input);

        //Expected
        expect(retrieved, expected);
      });
      test('jacobianCompute test', () {
        //Arrange
        Matrix parameters = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        Vector distances = Vector.fromList([0.5, 0.5, 0.5]);
        Vector input = Vector.fromList([2.0, 1.0]);
        Matrix expected = Matrix.fromList([
          [1.0, 0.0],
          [-1.0, 0.0],
          [0.0, -1.0]
        ]);

        //Act
        MultilaterationFunction testFunction = MultilaterationFunction();
        testFunction.distances = distances;
        testFunction.parameters = parameters;
        Matrix retrieved = testFunction.computeJacobian(input);

        //Expected
        expect(retrieved, expected);
      });
      test('numFunctions test', () {
        //Arrange
        Matrix parameters = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        Vector distances = Vector.fromList([0.5, 0.5, 0.5]);
        int expected = 3;

        //Act
        MultilaterationFunction testFunction = MultilaterationFunction();
        testFunction.distances = distances;
        testFunction.parameters = parameters;
        int retrieved = testFunction.numFunctions();

        //Expected
        expect(retrieved, expected);
      });
    });
  }
}
