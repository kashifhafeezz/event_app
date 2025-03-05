import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    required this.title,
    this.validator,
    super.key,
  });
  final List<T> items;
  final T? selectedValue;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T?>? validator;
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
                .titleSmallTextStyle(context: context)
                ?.copyWith(fontWeight: AppFontWeight().regular),
          ),
        ),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            value: selectedValue,
            hint: Text(
              hintText,
              style: AppTextStyles()
                  .labelLargeTextStyle(context: context)
                  ?.copyWith(
                    fontWeight: AppFontWeight().regular,
                    color: Colors.grey.shade600,
                  ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            validator: validator,
            isExpanded: true,
            style: context.theme.textTheme.bodyMedium,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 16, bottom: 16, right: 10),
            ),
            items: items.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
