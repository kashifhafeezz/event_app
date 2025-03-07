import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppHeaderWidget extends StatelessWidget {
  const AppHeaderWidget({super.key, this.title = ''});
  final String title;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 1,
      child: Center(
        child: Column(
          children: [
            Assets.images.riyadhLoreal.image(
              width: 300,
              height: 160,
              fit: BoxFit.fill,
            ),
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  title,
                  style: AppTextStyles()
                      .titleLargeTextStyle(
                        context: context,
                        textColor: context.colorScheme.primary,
                      )
                      ?.copyWith(fontWeight: AppFontWeight().semiBold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
