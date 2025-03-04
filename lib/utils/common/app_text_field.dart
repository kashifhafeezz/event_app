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
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final ValueChanged<dynamic>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int? maxlines;
  final String title;

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
                .titleMediumTextStyle(context: context)
                ?.copyWith(fontWeight: AppFontWeight().regular),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: textInputType,
          style: context.theme.textTheme.bodySmall,
          maxLines: maxlines,
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
