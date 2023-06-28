import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}
