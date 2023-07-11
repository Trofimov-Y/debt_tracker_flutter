import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  const DecimalTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')).formatEditUpdate(
      oldValue,
      newValue,
    );
  }
}
