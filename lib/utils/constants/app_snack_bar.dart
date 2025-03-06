import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_colors.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  factory AppSnackBar() => _singleton;
  AppSnackBar._internal();
  static final AppSnackBar _singleton = AppSnackBar._internal();

  OverlayEntry? _overlayEntry;

  void showErrorSnackBar({
    required BuildContext context,
    required String errorMessage,
  }) {
    _showTopSnackBar(
      context: context,
      message: errorMessage,
      backgroundColor: AppColors().alert,
    );
  }

  void showSuccessSnackBar({
    required BuildContext context,
    required String successMessage,
  }) {
    _showTopSnackBar(
      context: context,
      message: successMessage,
      backgroundColor: context.colorScheme.primary,
    );
  }

  void _showTopSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    // Remove existing overlay
    _overlayEntry?.remove();

    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPadding,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: AppTextStyles().titleSmallTextStyle(
                context: context,
                textColor: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    Overlay.of(context).insert(_overlayEntry!);

    // Duration
    Future.delayed(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}
