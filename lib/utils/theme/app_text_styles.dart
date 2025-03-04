import 'package:event_app/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  factory AppTextStyles() {
    return _singleton;
  }

  AppTextStyles._internal();

  static final AppTextStyles _singleton = AppTextStyles._internal();
  final _weight = AppFontWeight();
  final _fontSize = AppFontSize();

  TextStyle? displayLargeTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.displayLarge?.copyWith(
      fontSize: _fontSize.displayLarge,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? displayMediumTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.displayMedium?.copyWith(
      fontSize: _fontSize.displayMedium,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? displaySmallTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.displaySmall?.copyWith(
      fontSize: _fontSize.displaySmall,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? headLineLargeTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.headlineLarge?.copyWith(
      fontSize: _fontSize.headlineLarge,
      inherit: true,
      color: textColor,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? headLineMediumTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.headlineMedium?.copyWith(
      fontSize: _fontSize.headlineMedium,
      color: textColor,
      height: lineHeight,
      inherit: true,
      fontWeight: _weight.medium,
    );
  }

  TextStyle? headLineSmallTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.headlineSmall?.copyWith(
      fontSize: _fontSize.headlineSmall,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? titleLargeTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.titleLarge?.copyWith(
      fontSize: _fontSize.titleLarge,
      color: textColor,
      height: lineHeight,
      inherit: true,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? titleMediumTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.titleMedium?.copyWith(
      fontSize: _fontSize.titleMedium,
      color: textColor,
      height: lineHeight,
      inherit: true,
      fontWeight: _weight.medium,
    );
  }

  TextStyle? titleSmallTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.titleSmall?.copyWith(
      fontSize: _fontSize.titleSmall,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.regular,
    );
  }

  TextStyle? bodyLargeTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
    double fontSize = 20,
  }) {
    return context.theme.textTheme.bodyLarge?.copyWith(
      fontSize: _fontSize.bodyLarge,
      color: textColor,
      height: lineHeight,
      inherit: true,
      fontWeight: _weight.bold,
    );
  }

  TextStyle? bodyMediumTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.bodyMedium?.copyWith(
      fontSize: _fontSize.bodyMedium,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.medium,
    );
  }

  TextStyle? bodySmallTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.bodySmall?.copyWith(
      fontSize: _fontSize.bodySmall,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.semiBold,
    );
  }

  TextStyle? labelLargeTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.labelLarge?.copyWith(
      fontSize: _fontSize.labelLarge,
      color: textColor,
      height: lineHeight,
      fontWeight: _weight.semiBold,
      inherit: true,
    );
  }

  TextStyle? labelMediumTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.labelMedium?.copyWith(
      fontSize: _fontSize.labelMedium,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.medium,
    );
  }

  TextStyle? labelSmallTextStyle({
    required BuildContext context,
    Color? textColor,
    double? lineHeight,
  }) {
    return context.theme.textTheme.labelSmall?.copyWith(
      fontSize: _fontSize.labelSmall,
      color: textColor,
      inherit: true,
      height: lineHeight,
      fontWeight: _weight.medium,
    );
  }
}

///------- Font Weight -------///
class AppFontWeight {
  FontWeight regular = FontWeight.w400;
  FontWeight medium = FontWeight.w500;
  FontWeight semiBold = FontWeight.w600;
  FontWeight bold = FontWeight.w700;
}

///------- Font Size -------///
class AppFontSize {
  double displayLarge = 57;
  double displayMedium = 45;
  double displaySmall = 36;

  double headlineLarge = 32;
  double headlineMedium = 28;
  double headlineSmall = 24;

  double titleLarge = 22;
  double titleMedium = 18;
  double titleSmall = 16;

  double bodyLarge = 20;
  double bodyMedium = 14;
  double bodySmall = 12;

  double labelLarge = 13;
  double labelMedium = 12;
  double labelSmall = 11;
}
