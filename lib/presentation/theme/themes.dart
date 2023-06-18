import 'package:debt_tracker/presentation/theme/color_schemes.dart';
import 'package:debt_tracker/presentation/theme/text_theme.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: fontFamily,
  textTheme: textTheme,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    filled: true,
  ),
  colorScheme: lightColorScheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: fontFamily,
  textTheme: textTheme,
  colorScheme: darkColorScheme,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    filled: true,
  ),
);
