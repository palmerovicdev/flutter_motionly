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