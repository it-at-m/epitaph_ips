import 'dart:math';
import 'package:ml_linalg/linalg.dart';
import 'package:data/matrix.dart' as data;
import 'package:data/type.dart';
import 'package:vector_math/vector_math_64.dart' show Vector2;

/// A collection of methods from various Python libraries (predominantly SciPy and NumPy) written in Dart
/// These methods are mainly used for creating or manipulating matrices
/// While Dart matrix libraries exist, they do not encompass the scope of well established Python libraries

Matrix reshapeZ(var z, int dimZ, int nDim) {
  assert(z is num || z is Vector || z is List<Vector> || z is Matrix,
      'z must be num, Vector, List<Vector> or Matrix');
  z = atLeast2D(z);

  assert(z.rowsNum == 1 || z.columnsNum == 1,
      'z must be a flat row or a flat column');
  assert(z.rowsNum == dimZ || z.columnsNum == dimZ,
      'dimZ must equal z rowsNum or z columnsNum');

  if (z.columnsNum == dimZ) {
    z = z.transpose();
  }

  if (nDim == 0) {
    return Matrix.fromList([
      [z.getRow(0).elementAt(0)]
    ]);
  } else if (nDim == 1) {
    return Matrix.fromColumns([z.getColumn(0)]);
  }

  return z;
}

Matrix blockDiag(List arrays) {
  if (arrays.isEmpty) {
    return Matrix.empty();
  } else if (arrays.length == 1) {
    if (arrays.first is num) {
      return Matrix.scalar(arrays.first, 1);
    } else if (arrays.first is Matrix) {
      return arrays.first;
    }
  }

  List transformed = [];

  for (var element in arrays) {
    transformed.add(atLeast2D(element));
  }

  int rows = 0;
  int columns = 0;

  for (var element in transformed) {
    rows = rows + element.rowsNum as int;
    columns = columns + element.columnsNum as int;
  }

  List<double> output = List.filled(rows * columns, 0);
  int cellNumber = 0;

  for (var matrix in transformed) {
    matrix.forEach((vector) {
      vector.forEach((scalar) {
        output[cellNumber] = scalar;
        cellNumber = cellNumber + 1;
      });

      cellNumber = cellNumber + columns - vector.length as int;
    });

    cellNumber = cellNumber + matrix.columnsNum as int;
  }

  return Matrix.fromFlattenedList(output, rows, columns);
}

Matrix atLeast2D(final array) {
  if (array is List<Vector>) {
    return Matrix.fromColumns(array);
  } else if (array is num) {
    return Matrix.column([array as double]);
  } else if (array is Vector) {
    return Matrix.fromColumns([array]);
  }

  assert(array is Matrix);

  return array;
}

Matrix filledWithZeros(int rows, {int? columns}) {
  return filledWithScalar(rows, columns, 0);
}

Matrix filledWithOnes(int rows, {int? columns}) {
  return filledWithScalar(rows, columns, 1);
}

Matrix filledWithScalar(int rows, int? columns, num scalar) {
  columns ??= rows;
  assert(rows > 0 && columns > 0);

  List<Vector> listOfRows = [];
  Vector scalarVector = Vector.filled(columns, scalar);

  for (int i = 0; i < rows; i++) {
    listOfRows.add(scalarVector);
  }

  return Matrix.fromRows(listOfRows);
}

Matrix toInverse(Matrix input) {
  assert(input.isSquare, 'input must have equal numbers of columns and rows');
  return Matrix.fromList(matrixSolve(fromIterable(input.toList()),
          fromIterable(Matrix.identity(input.rowsNum).toList())))
      .transpose();
}

Matrix diag(Matrix input) {
  int min = input.rowsNum;
  int max = input.columnsNum;

  if (min > max) {
    min = input.columnsNum;
    max = input.rowsNum;
  }

  List<double> output = [];

  for (int i = 0; i < min; i++) {
    output.add(input[i][i]);
  }

  return Matrix.fromList([output]);
}

Matrix transposeToRow(Matrix input) {
  assert(input.rowsNum == 1 || input.columnsNum == 1);

  if (input.rowsNum != 1) {
    return input.transpose();
  }

  return input;
}

Matrix transposeToColumn(Matrix input) {
  assert(input.rowsNum == 1 || input.columnsNum == 1);

  if (input.columnsNum != 1) {
    return input.transpose();
  }

  return input;
}

Matrix outer(Matrix first, Matrix second) {
  List<Vector> output = [];
  bool firstIsVector = first.rowsNum == 1 || first.columnsNum == 1;
  bool secondIsVector = second.rowsNum == 1 || second.columnsNum == 1;

  if (!firstIsVector && !secondIsVector) {
    List<double> n = [];
    List<double> m = [];

    for (var row in first) {
      for (var element in row) {
        n.add(element);
      }
    }

    for (var row in second) {
      for (var element in row) {
        m.add(element);
      }
    }

    first = Matrix.fromList([n]);
    second = Matrix.fromList([m]);
  }

  for (var v in transposeToRow(first)[0]) {
    List<double> newVector = [];

    for (var u in transposeToRow(second)[0]) {
      newVector.add(u * v);
    }

    output.add(Vector.fromList(newVector));
  }

  return Matrix.fromRows(output);
}

Matrix broadcast(Matrix input, int numberOfRows) {
  assert(numberOfRows > 0, 'Parameter numberOfRows has to be larger than 0');
  assert(input.columnsNum == 1 || input.rowsNum == 1,
      'At least one dimension has to be larger than 1');

  List<List<double>> output = [];

  for (int i = 0; i < numberOfRows; i++) {
    output.add(input[0].toList());
  }

  return Matrix.fromList(output);
}

double roundDouble(double value, int places) {
  assert(places > 0, 'Parameter places has to be larger than 0');
  double mod = pow(10.0, places) as double;
  return ((value * mod).round().toDouble() / mod);
}

List<List<double>> fromIterable(List<Iterable<double>> input) {
  List<List<double>> output = [];

  for (var element in input) {
    output.add(element.toList());
  }

  return output;
}

//Frobenius normal form
double normF(Matrix a) {
  double total = 0;

  double scale = a[0].max();

  if (scale == 0.0) return 0.0;

  final int size = a.length;

  for (int i = 0; i < size; i++) {
    double val = a[i][0] / scale;
    total += val * val;
  }

  return scale * sqrt(total);
}

Matrix matrixInsert(Matrix src, Matrix dest, int startRow, int startColumn) {
  assert(!startRow.isNegative && !startColumn.isNegative,
      'Indexes cannot be less than 0');
  assert(
      dest.rowsNum - startRow >= src.rowsNum &&
          dest.columnsNum - startColumn >= src.columnsNum,
      'dest Matrix needs to fit into src Matrix at the given row and column');
  List<List<double>> tmp = fromIterable(dest.toList());

  for (int i = 0; i < src.rowsNum; i++) {
    for (int j = 0; j < src.columnsNum; j++) {
      tmp[startRow + i][startColumn + j] = src[i][j];
    }
  }

  return Matrix.fromList(tmp);
}

Matrix reshape(Matrix input, List<List<double>> fixedList) {
  if (input.isEmpty) {
    return Matrix.fromList(fixedList);
  }

  List<double> flat = input
      .toList()
      .reduce((value, element) => value.toList() + element.toList())
      .toList();
  return Matrix.fromFlattenedList(
      flat, fixedList.length, fixedList.first.length);
}

List<List<double>> choleskyDecomposition(List<List<double>> input) {
  data.Matrix<double> cholesky =
      data.Matrix<double>.fromRows(DataType.float64, input).cholesky.L;

  List<List<double>> output = [];

  for (int i = 0; i < cholesky.rowCount; i++) {
    List<double> row = [];

    for (int j = 0; j < cholesky.columnCount; j++) {
      row.add(cholesky.get(i, j));
    }

    output.add(row);
  }

  return output;
}

List<List<double>> matrixSolve(List<List<double>> a, List<List<double>> b) {
  data.Matrix<double> solved = data.Matrix<double>.fromRows(DataType.float64, a)
      .solve(data.Matrix<double>.fromRows(DataType.float64, b));
  List<List<double>> output = [];

  for (int i = 0; i < solved.columnCount; i++) {
    List<double> row = [];

    for (int j = 0; j < solved.rowCount; j++) {
      row.add(solved.get(j, i));
    }

    output.add(row);
  }

  return output;
}

Matrix orderByDerivative(Matrix q, int dim, int blockSize) {
  assert(dim > 1 && dim < 5, 'dim must be 2, 3 or 4');
  assert(dim == q.rowsNum, 'dim must equal the number of rows in q');
  int n = dim * blockSize;
  List<List<double>> d = [];

  for (int i = 0; i < q.rowsNum; i++) {
    for (int j = 0; j < q.columnsNum; j++) {
      Matrix f = Matrix.identity(blockSize) * q[i][j];
      int newX = (i + j) ~/ n;
      int newY = (i + j) % n;

      for (int ix = newX; ix < newX + blockSize; ix++) {
        List<double> row = [];
        for (int iy = newY; iy < newY + blockSize; iy++) {
          row.add(f[ix - newX][iy - newY]);
        }

        d.add(row);
      }
    }
  }

  return Matrix.fromList(d);
}

List<Vector2> fromMatrix(Matrix input) {
  List<Vector2> output = [];

  for (var row in input) {
    output.add(Vector2(row.elementAt(0), row.elementAt(1)));
  }

  return output;
}

List<List<double>> matrixToList(Matrix input) {
  List<List<double>> output = [];

  for (var row in input) {
    output.add(row.toList());
  }

  return output;
}

/// Creates a matrix with [input] as its diagonal
Matrix diagBlocks(Matrix input) {
  List<List<double>> output = [];

  for (int i = 0; i < input.rowsNum * 2; i++) {
    output.add(List.filled(input.columnsNum * 2, 0));
  }

  for (int i = 0; i < input.rowsNum; i++) {
    for (int j = 0; j < input.columnsNum; j++) {
      output[i][j] = input[i][j];
      output[i + input.rowsNum][j + input.columnsNum] = input[i][j];
    }
  }

  return Matrix.fromList(output);
}
