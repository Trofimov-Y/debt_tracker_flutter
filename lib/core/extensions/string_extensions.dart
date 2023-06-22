extension StringExtensions on String {
  String get capitalizedEachFirstLetter {
    return split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }
}
