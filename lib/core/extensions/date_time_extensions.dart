import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get dMMMMFormat => DateFormat('d MMMM').format(this);
}
