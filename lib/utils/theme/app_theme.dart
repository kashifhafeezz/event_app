import 'package:event_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  factory AppTheme() => _singleton;
  AppTheme._internal();
  static final AppTheme _singleton = AppTheme._internal();

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  static TextStyle style = const TextStyle(
    fontFamily: FontFamily.poppins,
    color: Colors.black,
  );

  ///------- Text Style -------///
  static final TextTheme _baseTextTheme = TextTheme(
    bodyLarge: style,
    bodyMedium: style,
    bodySmall: style,
    displayLarge: style,
    displayMedium: style,
    displaySmall: style,
    headlineLarge: style,
    headlineMedium: style,
    headlineSmall: style,
    labelLarge: style,
    labelMedium: style,
    labelSmall: style,
    titleLarge: style,
    titleMedium: style,
    titleSmall: style,
  );

  ///------- Colors -------///
  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xff456e8f),
    onPrimary: Colors.white,
    secondary: const Color(0xffadd1ee),
    onSecondary: Colors.white,
    tertiary: Colors.blue.shade300,
    onTertiary: Colors.white,
    error: const Color(0xffF1312A),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xff456e8f),
    onPrimary: Colors.white,
    secondary: const Color(0xffadd1ee),
    onSecondary: Colors.white,
    tertiary: Colors.blue.shade300,
    onTertiary: Colors.white,
    error: const Color(0xffF1312A),
    onError: Colors.white,
    surface: const Color(0xff333333),
    onSurface: Colors.black,
  );

  ///------- Light Theme -------///
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: _baseTextTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    primaryTextTheme: _baseTextTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: Colors.white,
  );

  ///------- Dark Theme -------///
  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: _baseTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    primaryTextTheme: _baseTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: const Color(0xff333333),
  );
}
