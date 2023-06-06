import 'package:debt_tracker/theme/color_schemes.dart';
import 'package:debt_tracker/theme/text_theme.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: fontFamily,
  textTheme: textTheme,
  colorScheme: lightColorScheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: fontFamily,
  textTheme: textTheme,
  colorScheme: darkColorScheme,
);
