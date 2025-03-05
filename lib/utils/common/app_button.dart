import 'package:event_app/utils/contants/app_const.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    super.key,
    this.onPressed,
    this.width,
    this.height = 50,
    this.isLoading = false,
    this.disabled = false,
    this.textStyle,
    this.buttonColor,
    this.buttonIcon,
  });
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isLoading;
  final bool disabled;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Widget? buttonIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        // onPressed: (disabled || isLoading) ? null : onPressed,
        onPressed: disabled ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? context.colorScheme.primary,
          foregroundColor: buttonColor ?? context.colorScheme.onPrimary,
          disabledBackgroundColor: context.colorScheme.secondary,
          disabledForegroundColor: context.colorScheme.secondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConst().screenHorizontalPadding,
          ),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (buttonIcon != null) buttonIcon!,
                  Text(
                    text,
                    style: textStyle ??
                        AppTextStyles().titleMediumTextStyle(
                          context: context,
                          textColor: context.colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
