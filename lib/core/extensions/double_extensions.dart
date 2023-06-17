extension DoubleExtenstions on double {
  (int, int) separateParts(int decimalPlaces) {
    final parts = toStringAsFixed(decimalPlaces).split('.');
    final integerPart = int.parse(parts[0]);
    final fractionalPart = int.parse(parts[1]);
    return (integerPart, fractionalPart);
  }
}
