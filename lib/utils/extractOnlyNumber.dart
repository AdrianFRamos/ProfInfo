String extractOnlyNumber(String input) {
  final match = RegExp(r'\d+').firstMatch(input);
  return match?.group(0) ?? '';
}
