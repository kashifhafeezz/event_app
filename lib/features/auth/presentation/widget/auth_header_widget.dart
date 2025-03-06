import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Assets.images.lldd.image(height: 100),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          child: Text(
            title,
            style: AppTextStyles().titleLargeTextStyle(context: context),
          ),
        ),
      ],
    );
  }
}
