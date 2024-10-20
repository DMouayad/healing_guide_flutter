import 'package:flutter/material.dart';

class AppTheme {
  static const kFontFamily = 'almarai';

  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2B75CA),
    secondary: const Color(0xFF9CD161),
    brightness: Brightness.dark,
  );

  static final _lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF2B75CA),
    secondary: const Color(0xFF9CD161),
    surface: const Color(0xFFFAFBFD),
    onSurface: const Color(0xFF444444),
  );

  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    fontFamily: kFontFamily,
  );
  static final darkThemeData = ThemeData(
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    fontFamily: kFontFamily,
  );
}
