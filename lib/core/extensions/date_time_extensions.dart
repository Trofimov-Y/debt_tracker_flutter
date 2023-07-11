// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get ddMMhhmm => DateFormat('dd MMMM hh:mm').format(this);

  String get dMMMMFormat => DateFormat('d MMMM').format(this);

  String get EEEddMMMYFormat => DateFormat('EEE, dd MMM, y').format(this);

  String get EEEddMMMFormat => DateFormat('EEE, dd MMM').format(this);
}
