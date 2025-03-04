import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get mqWidth => MediaQuery.sizeOf(this).width;

  double get mqHeight => MediaQuery.sizeOf(this).height;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  bool get isDarkTheme => theme.colorScheme.brightness == Brightness.dark;
}
