import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/matrix_helpers.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';
import 'package:vector_math/vector_math_64.dart' show Vector2;

class MatrixHelpersTest {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*MatrixHelpersTest Method Unit Tests*', () {
      group('reshapeZ', () {
        test('z invalid', () {
          //Arrange
          String z = 'This is Spartan-117';
          int dimZ = 2;
          int nDim = 0;

          //Act and expected
          expect(() => reshapeZ(z, dimZ, nDim), throwsAssertionError);
        });

        test('z is not flat', () {
          //Arrange
          Matrix z = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          int dimZ = 2;
          int nDim = 0;

          //Act and expected
          expect(() => reshapeZ(z, dimZ, nDim), throwsAssertionError);
        });

        test('dimZ is not equal z rowsNum or z columnsNum', () {
          //Arrange
          Matrix z = Matrix.fromList([
            [1, 1, 7]
          ]);

          int dimZ = 2;
          int nDim = 0;

          //Act and expected
          expect(() => reshapeZ(z, dimZ, nDim), throwsAssertionError);
        });

        test('nDim == 0', () {
          //Arange
          Matrix z = Matrix.fromList([
            [117, 117, 117]
          ]);

          int dimZ = 3;
          int nDim = 0;
          Matrix expected = Matrix.fromList([
            [117]
          ]);

          //Act
          Matrix received = reshapeZ(z, dimZ, nDim);

          //Expect
          expect(received, expected);
        });

        test('nDim == 0', () {
          //Arange
          Matrix z = Matrix.fromList([
            [117, 117, 117]
          ]);

          int dimZ = 3;
          int nDim = 1;
          Matrix expected = Matrix.fromList([
            [117],
            [117],
            [117]
          ]);

          //Act
          Matrix received = reshapeZ(z, dimZ, nDim);

          //Expect
          expect(received, expected);
        });

        test('nDim != 0 && nDim != 1', () {
          //Arange
          Matrix z = Matrix.fromList([
            [117, 117, 117]
          ]);

          int dimZ = 3;
          int nDim = 117;
          Matrix expected = Matrix.fromList([
            [117],
            [117],
            [117]
          ]);

          //Act
          Matrix received = reshapeZ(z, dimZ, nDim);

          //Expect
          expect(received, expected);
        });
      });

      group('*blockDiag*', () {
        test('empty list', () {
          //Arrange
          List input = [];
          Matrix expected = Matrix.empty();

          //Act
          Matrix received = blockDiag(input);

          //Expected
          expect(received, expected);
        });

        test('list', () {
          //Arrange
          List<double> input = [1, 1, 7];
          Matrix expected = Matrix.fromList([
            [1, 0, 0],
            [0, 1, 0],
            [0, 0, 7]
          ]);

          //Act
          Matrix received = blockDiag(input);

          //Expected
          expect(received, expected);
        });

        test('scalar', () {
          //Arrange
          List<double> input = [117];
          Matrix expected = Matrix.fromList([
            [117]
          ]);

          //Act
          Matrix received = blockDiag(input);

          //Expected
          expect(received, expected);
        });

        test('matrix', () {
          //Arrange
          List<Matrix> input = [
            Matrix.fromList([
              [1, 1, 7]
            ])
          ];
          Matrix expected = Matrix.fromList([
            [1, 1, 7]
          ]);

          //Act
          Matrix received = blockDiag(input);

          //Expected
          expect(received, expected);
        });
      });

      group('*atLeast2D*', () {
        test('invalid parameter', () {
          //Arrange
          String input = 'This is Spartan-117';

          //Act and expected
          expect(() => atLeast2D(input), throwsAssertionError);
        });

        test('List<Vector> as parameter', () {
          //Arrange
          List<Vector> input = [
            Vector.fromList([117]),
          ];

          Matrix expected = Matrix.fromList([
            [117],
          ]);

          //Act
          Matrix received = atLeast2D(input);

          //Expect
          expect(received, expected);
        });

        test('num as parameter', () {
          //Arrange
          double input = 117;

          Matrix expected = Matrix.fromList([
            [117]
          ]);

          //Act
          Matrix received = atLeast2D(input);

          //Expect
          expect(received, expected);
        });

        test('Vector as parameter', () {
          //Arrange
          Vector input = Vector.fromList([117]);

          Matrix expected = Matrix.fromList([
            [117]
          ]);

          //Act
          Matrix received = atLeast2D(input);

          //Expect
          expect(received, expected);
        });
      });

      group('*filledWithZeros*', () {
        test('rows', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
          ]);

          //Act
          Matrix received = filledWithZeros(3);

          //Expected
          expect(received, expected);
        });

        test('rows and columns', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
          ]);

          //Act
          Matrix received = filledWithZeros(4, columns: 3);

          //Expected
          expect(received, expected);
        });
      });

      group('*filledWithOnes*', () {
        test('rows', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1]
          ]);

          //Act
          Matrix received = filledWithOnes(3);

          //Expected
          expect(received, expected);
        });

        test('rows and columns', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1]
          ]);

          //Act
          Matrix received = filledWithOnes(4, columns: 3);

          //Expected
          expect(received, expected);
        });
      });

      group('*filledWithScalar*', () {
        test('rows', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [117, 117, 117],
            [117, 117, 117],
            [117, 117, 117]
          ]);

          //Act
          Matrix received = filledWithScalar(3, null, 117);

          //Expected
          expect(received, expected);
        });

        test('rows and columns', () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [117, 117, 117],
            [117, 117, 117],
            [117, 117, 117],
            [117, 117, 117]
          ]);

          //Act
          Matrix received = filledWithScalar(4, 3, 117);

          //Expected
          expect(received, expected);
        });

        test('rows and columns greater than zero', () {
          //Arrange, act and expected
          expect(() => filledWithScalar(-117, 117, 117), throwsAssertionError);
        });
      });

      group('toInverse', () {
        test('input not square', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7]
          ]);

          //Act and expected
          expect(() => toInverse(input), throwsAssertionError);
        });

        test('no assertion errors', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [2, 1],
            [6, 4]
          ]);

          Matrix expected = Matrix.fromList([
            [2, -0.5],
            [-3, 1]
          ]);

          //Act
          Matrix received = toInverse(input);

          //Expected
          expect(received, expected);
        });
      });

      test('diag', () {
        //Arrange
        Matrix input = Matrix.fromList([
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ]);

        Matrix expected = Matrix.fromList([
          [1, 1, 7]
        ]);

        //Act
        Matrix received = diag(input);

        //Expected
        expect(received, expected);
      });

      group('*transposeToRow*', () {
        test('neither rows or columns are one-dimensional', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          //Act and expected
          expect(() => transposeToRow(input), throwsAssertionError);
        });

        test('column to row', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1],
            [1],
            [7]
          ]);

          Matrix expected = Matrix.fromList([
            [1, 1, 7]
          ]);

          //Act
          Matrix received = transposeToRow(input);

          //Expected
          expect(received, expected);
        });

        test('row to row', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7]
          ]);

          Matrix expected = Matrix.fromList([
            [1, 1, 7]
          ]);

          //Act
          Matrix received = transposeToRow(input);

          //Expected
          expect(received, expected);
        });
      });

      group('*transposeToColumn*', () {
        test('neither rows or columns are one-dimensional', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          //Act and expected
          expect(() => transposeToColumn(input), throwsAssertionError);
        });

        test('row to column', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7]
          ]);

          Matrix expected = Matrix.fromList([
            [1],
            [1],
            [7]
          ]);

          //Act
          Matrix received = transposeToColumn(input);

          //Expected
          expect(received, expected);
        });

        test('column to column', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1],
            [1],
            [7]
          ]);

          Matrix expected = Matrix.fromList([
            [1],
            [1],
            [7]
          ]);

          //Act
          Matrix received = transposeToColumn(input);

          //Expected
          expect(received, expected);
        });
      });

      test('outer', () {
        //Arrange
        Matrix first = Matrix.fromList([
          [0, 1],
          [1, 7]
        ]);

        Matrix second = Matrix.fromList([
          [5, 1],
          [1, 7]
        ]);

        Matrix expected = Matrix.fromList([
          [0, 0, 0, 0],
          [5, 1, 1, 7],
          [5, 1, 1, 7],
          [35, 7, 7, 49]
        ]);

        //Act
        Matrix received = outer(first, second);

        //Expected
        expect(received, expected);
      });

      group('*broadcast*', () {
        test('neither columns nor rows are one-dimensional', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7],
          ]);

          int numberOfRows = 117;

          //Act and expected
          expect(() => broadcast(input, numberOfRows), throwsAssertionError);
        });

        test('numberOfRows is less than 1', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7],
          ]);

          int numberOfRows = 0;

          //Act and expected
          expect(() => broadcast(input, numberOfRows), throwsAssertionError);
        });

        test('no assertion errors', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1, 7],
          ]);

          int numberOfRows = 3;

          Matrix expected = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          //Act
          Matrix received = broadcast(input, numberOfRows);

          //Expected
          expect(received, expected);
        });
      });

      group('*roundDouble*', () {
        test('places less than 1', () {
          //Arrange
          double value = 1.17;
          int places = -1;

          //Act and expected
          expect(() => roundDouble(value, places), throwsAssertionError);
        });

        test('no assertion errors', () {
          //Arrange
          double value = 1.17;
          int places = 1;
          double expected = 1.2;

          //Act
          double received = roundDouble(value, places);

          //Expected
          expect(received, expected);
        });
      });

      test('fromIterable', () {
        //Arrange
        List<Iterable<double>> input = [
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ];

        List<List<double>> expected = [
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ];

        //Act
        List<List<double>> received = fromIterable(input);

        //Expected
        expect(received, expected);
      });

      test('normF', () {
        //Arrange
        Matrix input = Matrix.fromList([
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ]);

        double expected = 1.7320508075688772;

        //Act
        double received = normF(input);

        //Expected
        expect(received, expected);
      });

      group('*matrixInsert*', () {
        test('negative value for startRow not allowed', () {
          //Arrange
          Matrix dest = Matrix.fromList([
            [0, 0, 7],
            [0, 0, 7],
            [1, 1, 7],
          ]);

          Matrix src = Matrix.fromList([
            [1, 1],
            [1, 1]
          ]);

          int startRow = -1;
          int startColumn = 0;

          //Act and expect
          expect(() => matrixInsert(src, dest, startRow, startColumn),
              throwsAssertionError);
        });

        test('negative values for startColumn not allowed', () {
          //Arrange
          Matrix dest = Matrix.fromList([
            [0, 0, 7],
            [0, 0, 7],
            [1, 1, 7],
          ]);

          Matrix src = Matrix.fromList([
            [1, 1],
            [1, 1]
          ]);

          int startRow = 0;
          int startColumn = -1;

          //Act and expect
          expect(() => matrixInsert(src, dest, startRow, startColumn),
              throwsAssertionError);
        });

        test('src does not fit in dest', () {
          //Arrange
          Matrix dest = Matrix.fromList([
            [0, 0, 7],
            [0, 0, 7],
            [1, 1, 7],
          ]);

          Matrix src = Matrix.fromList([
            [1, 1],
            [1, 1],
            [1, 1],
            [1, 1]
          ]);

          int startRow = 0;
          int startColumn = 0;

          //Act and expect
          expect(() => matrixInsert(src, dest, startRow, startColumn),
              throwsAssertionError);
        });

        test('no assertion errors', () {
          //Arrange
          Matrix dest = Matrix.fromList([
            [0, 0, 7],
            [0, 0, 7],
            [1, 1, 7],
          ]);

          Matrix src = Matrix.fromList([
            [1, 1],
            [1, 1]
          ]);

          Matrix expected = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          int startRow = 0;
          int startColumn = 0;

          //Act
          Matrix received = matrixInsert(src, dest, startRow, startColumn);

          //Expected
          expect(received, expected);
        });
      });

      group('reshape', () {
        test('no assertion errors', () {
          //Arrange
          Matrix input = Matrix.fromList([
            [1, 1],
            [7, 1],
            [1, 7]
          ]);

          List<List<double>> fixedList = [
            [0, 0, 0],
            [0, 0, 0]
          ];

          Matrix expected = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7]
          ]);

          //Act
          Matrix received = reshape(input, fixedList);

          //Expected
          expect(received, expected);
        });
      });

      test('choleskyDecomposition', () {
        //Arange
        List<List<double>> input = [
          [4, 12, -16],
          [12, 37, -43],
          [-16, -43, 98]
        ];

        List<List<double>> expected = [
          [2, 0, 0],
          [6, 1, 0],
          [-8, 5, 3]
        ];

        //Act
        List received = choleskyDecomposition(input);

        //Expected
        expect(received, expected);
      });

      test('matrixSolve', () {
        //Arrange
        List<List<double>> a = [
          [1, 6],
          [4, -2],
          [3, 8]
        ];

        List<List<double>> b = [
          [13],
          [0],
          [19]
        ];

        List<List<double>> expected = [
          [1, 2, 0]
        ];

        //Act
        List<List<double>> received = matrixSolve(a, b)
            .map((e) => e.map((e) => e.roundToDouble()).toList())
            .toList();

        //Expected
        expect(received, expected);
      });

      group('orderByDerivative', () {
        test('dim value invalid', () {
          //Arrange
          Matrix q = Matrix.fromList([
            [5, 1],
            [1, 7]
          ]);

          int dim = 1;

          int blockSize = 1;

          //Act and expect
          expect(
              () => orderByDerivative(q, dim, blockSize), throwsAssertionError);
        });

        test('dim not equal number of rows in q invalid', () {
          //Arrange
          Matrix q = Matrix.fromList([
            [5, 1],
            [1, 7]
          ]);

          int dim = 3;

          int blockSize = 1;

          //Act and expect
          expect(
              () => orderByDerivative(q, dim, blockSize), throwsAssertionError);
        });

        test('dim 2', () {
          //Arrange
          Matrix q = Matrix.fromList([
            [0, 1],
            [1, 7]
          ]);

          int dim = 2;

          int blockSize = 1;

          Matrix expected = Matrix.fromList([
            [0],
            [1],
            [1],
            [7],
          ]);

          //Act
          Matrix received = orderByDerivative(q, dim, blockSize);

          //Expect
          expect(expected, received);
        });

        test('dim 3', () {
          //Arrange
          Matrix q = Matrix.fromList([
            [1, 1, 7],
            [1, 1, 7],
            [1, 1, 7]
          ]);

          int dim = 3;

          int blockSize = 1;

          Matrix expected = Matrix.fromList([
            [1],
            [1],
            [7],
            [1],
            [1],
            [7],
            [1],
            [1],
            [7],
          ]);

          //Act
          Matrix received = orderByDerivative(q, dim, blockSize);

          //Expect
          expect(expected, received);
        });

        test('dim 4', () {
          //Arrange
          Matrix q = Matrix.fromList([
            [0, 1, 1, 7],
            [0, 1, 1, 7],
            [0, 1, 1, 7],
            [0, 1, 1, 7]
          ]);

          int dim = 4;

          int blockSize = 1;

          Matrix expected = Matrix.fromList([
            [0],
            [1],
            [1],
            [7],
            [0],
            [1],
            [1],
            [7],
            [0],
            [1],
            [1],
            [7],
            [0],
            [1],
            [1],
            [7]
          ]);

          //Act
          Matrix received = orderByDerivative(q, dim, blockSize);

          //Expect
          expect(expected, received);
        });
      });

      test('fromMatrix', () {
        //Arrange
        Matrix input = Matrix.fromList([
          [1, 1],
          [7, 1],
          [1, 7]
        ]);

        List<Vector2> expected = [
          Vector2(1, 1),
          Vector2(7, 1),
          Vector2(1, 7),
        ];

        //Act
        List<Vector2> received = fromMatrix(input);

        //Expected
        expect(received, expected);
      });

      test('matrixToList', () {
        //Arrange
        Matrix input = Matrix.fromList([
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ]);

        List<List<double>> expected = [
          [1, 1, 7],
          [1, 1, 7],
          [1, 1, 7]
        ];

        //Act
        List<List<double>> received = matrixToList(input);

        //Expect
        expect(received, expected);
      });

      test('diagBlocks', () {
        //Arrange
        Matrix input = Matrix.fromList([
          [1, 1, 7]
        ]);

        Matrix expected = Matrix.fromList([
          [1, 1, 7, 0, 0, 0],
          [0, 0, 0, 1, 1, 7],
        ]);

        //Act
        Matrix received = diagBlocks(input);

        //Expected
        expect(received, expected);
      });
    });
  }
}
