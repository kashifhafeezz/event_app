import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({required this.onMenuPressed, super.key});
  final VoidCallback onMenuPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.onPrimary,
      leadingWidth: 20,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        color: context.colorScheme.primary,
        onPressed: () => AppNavigation().navigateBack(context: context),
      ),
      title: GestureDetector(
        onTap: () => AppNavigation().navigateBack(context: context),
        behavior: HitTestBehavior.opaque,
        child: Text(
          context.l10n.back,
          style: AppTextStyles().titleMediumTextStyle(
            context: context,
            textColor: context.colorScheme.primary,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu_rounded, size: 30),
          color: context.colorScheme.primary,
          onPressed: onMenuPressed,
        ),
      ],
    );
  }
}
