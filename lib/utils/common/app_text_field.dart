import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hintText,
    required this.controller,
    required this.title,
    this.onChanged,
    this.validator,
    this.textInputType = TextInputType.text,
    this.maxlines = 1,
    this.suffixIcon,
    this.obscureText = false,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final ValueChanged<dynamic>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int? maxlines;
  final String title;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: AppTextStyles()
                .titleSmallTextStyle(context: context)
                ?.copyWith(fontWeight: AppFontWeight().regular),
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: textInputType,
          style: context.theme.textTheme.bodyMedium,
          maxLines: maxlines,
          //!TODO With The Keyboard Dismissal Widget
          // onTap: () {
          //   FocusManager.instance.primaryFocus!.unfocus();
          // },
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle:
                AppTextStyles().labelLargeTextStyle(context: context)?.copyWith(
                      fontWeight: AppFontWeight().regular,
                      color: Colors.grey.shade600,
                    ),
          ),
        ),
      ],
    );
  }
}
