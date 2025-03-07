import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/utils/common/fade_animation.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    required this.onMenuPressed,
    this.isSideMenuRequired = true,
    super.key,
  });
  final VoidCallback onMenuPressed;
  final bool isSideMenuRequired;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.surface,
      leadingWidth: 100,
      leading: GestureDetector(
        onTap: () => AppNavigation().navigateBack(context: context),
        behavior: HitTestBehavior.opaque,
        child: FadePositionAnimation(
          delay: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  context.l10n.back,
                  style: AppTextStyles().titleMediumTextStyle(
                    context: context,
                    textColor: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        if (isSideMenuRequired)
          FadePositionAnimation(
            delay: 1,
            begin: 100,
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, size: 30),
              color: context.colorScheme.primary,
              onPressed: onMenuPressed,
            ),
          ),
      ],
    );
  }
}
