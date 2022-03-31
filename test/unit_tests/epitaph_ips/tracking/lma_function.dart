import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/lma_function.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';

class LMAFunctionTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*LMAFunction Constructor Unit Tests*', () {
      test('constructor does not throw assertion test', () {
        //Arrange
        Matrix parameters = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        Vector distances = Vector.fromList([0.5, 0.5, 0.5]);

        //Act and expected
        expect(() => _MockLMAFunction(parameters, distances),
            isNot(throwsAssertionError));
      });
    });
    group('*LMAFunction Getter Unit Tests*', () {
      test('get parameters test', () {
        //Arrange
        Matrix parameters = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        Vector distances = Vector.fromList([0.5, 0.5, 0.5]);
        Matrix expected = Matrix.fromList([
          [1.0, 1.0],
          [3.0, 1.0],
          [2.0, 2.0]
        ]);

        //Act
        _MockLMAFunction testFunction = _MockLMAFunction(parameters, distances);
        Matrix retrieved = testFunction.parameters;

        //Expected
        expect(retrieved, expected);
      });
    });
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
        _MockLMAFunction testFunction = _MockLMAFunction(parameters, distances);
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
        _MockLMAFunction testFunction = _MockLMAFunction(parameters, distances);
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
        _MockLMAFunction testFunction = _MockLMAFunction(parameters, distances);
        int retrieved = testFunction.numFunctions();

        //Expected
        expect(retrieved, expected);
      });
    });
  }
}

///Mock class which implements [LMAFunction] (akin to a multilateration function)
class _MockLMAFunction extends LMAFunction {
  _MockLMAFunction(Matrix parameters, this._distances) {
    this.parameters = parameters;
  }

  final Vector _distances;

  @override
  Vector compute(Vector input) {
    return ((parameters.mapRows((row) => (row - input).pow(2)))
                .reduceColumns((combine, vector) => combine + vector)
                .sqrt() -
            _distances)
        .pow(2);
  }

  @override
  Matrix computeJacobian(Vector input) {
    Matrix first = parameters.mapRows((row) => (input - row));
    Vector divisor = (first.mapRows((row) => row.pow(2)))
        .reduceColumns((combine, vector) => combine + vector)
        .sqrt();

    List<Vector> tmpSecond = [];

    for (int i = 0; i < input.length; i++) {
      tmpSecond.add(divisor);
    }

    Matrix second = Matrix.fromColumns(tmpSecond).pow(-1);
    return first.multiply(second);
  }

  @override
  void adjustParameters(List<Beacon> beacons) {
    // TODO: implement adjustParameters
  }

  @override
  Vector computeInitialGuess(List<Beacon> beacons) {
    // TODO: implement computeInitialGuess
    throw UnimplementedError();
  }
}
