import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

const _nameMaxLength = 30;

FormFieldValidator<String> nameValidator(String emptyErrorText) {
  return (String? value) {
    return value.isNotNullOrEmpty && value!.length <= _nameMaxLength ? null : emptyErrorText;
  };
}

FormFieldValidator<String> emptyValidator(String errorText) {
  return (String? value) => value.isNotNullOrBlank ? null : errorText;
}

FormFieldValidator<String> amountValidator(
  String emptyErrorText,
  String lessThanZeroErrorText,
) {
  return (String? value) {
    if (value.isNullOrEmpty) return emptyErrorText;
    if (double.parse(value!) <= 0) return lessThanZeroErrorText;
    return null;
  };
}
