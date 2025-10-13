import 'dart:math';

String randomAscii(int length) {
  final random = Random();
  const start = 33;
  const end = 126;
  return String.fromCharCodes(
    List.generate(length, (_) => start + random.nextInt(end - start + 1)),
  );
}

String randomChinese(int length) {
  final random = Random();
  const start = 0x4E00;
  const end = 0x9FFF;
  return String.fromCharCodes(
    List.generate(length, (_) => start + random.nextInt(end - start)),
  );
}

String randomExtended(int length) {
  final random = Random();
  return String.fromCharCodes(
    List.generate(length, (_) => random.nextInt(0x3000) + 0x20),
  );
}

enum TraverseDirection {
  BOTTOM_UP,
  UP_BOTTOM,
  LEFT_RIGHT,
  RIGHT_LEFT,
  LEFT_UP_RIGHT_BOTTOM,
  RIGHT_BOTTOM_LEFT_UP,
  LEFT_BOTTOM_RIGHT_UP,
  RIGHT_UP_LEFT_BOTTOM,
}

List<List<T>> traverseMatrix<T>(List<List<T>> matrix, TraverseDirection direction) {
  final n = matrix.length;
  final m = matrix[0].length;
  final result = <List<T>>[];

  switch (direction) {
    case TraverseDirection.BOTTOM_UP:
      for (var row in matrix) {
        result.add(List.from(row));
      }
      break;

    case TraverseDirection.UP_BOTTOM:
      return traverseMatrix(
        matrix,
        TraverseDirection.BOTTOM_UP,
      ).reversed.toList();

    case TraverseDirection.RIGHT_LEFT:
      return traverseMatrix(
        matrix,
        TraverseDirection.LEFT_RIGHT,
      ).reversed.toList();

    case TraverseDirection.LEFT_RIGHT:
      for (var col = 0; col < m; col++) {
        final column = <T>[];
        for (var row = 0; row < n; row++) {
          column.add(matrix[row][col]);
        }
        result.add(column);
      }
      break;

    case TraverseDirection.RIGHT_BOTTOM_LEFT_UP:
      for (var d = 0; d < n + m - 1; d++) {
        final diag = <T>[];
        for (var i = 0; i < n; i++) {
          var j = d - i;
          if (j >= 0 && j < m) diag.add(matrix[i][j]);
        }
        if (diag.isNotEmpty) result.add(diag);
      }
      break;

    case TraverseDirection.LEFT_UP_RIGHT_BOTTOM:
      return traverseMatrix(
        matrix,
        TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
      ).reversed.toList();

    case TraverseDirection.RIGHT_UP_LEFT_BOTTOM:
      for (var d = 0; d < n + m - 1; d++) {
        final diag = <T>[];
        for (var i = 0; i < n; i++) {
          var j = (m - 1) - (d - i);
          if (j >= 0 && j < m) diag.add(matrix[i][j]);
        }
        if (diag.isNotEmpty) result.add(diag);
      }
      break;


    case TraverseDirection.LEFT_BOTTOM_RIGHT_UP:
      return traverseMatrix(
        matrix,
        TraverseDirection.RIGHT_UP_LEFT_BOTTOM,
      ).reversed.toList();
  }

  return result;
}
