import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    required this.onMenuPressed,
    super.key,
  });
  final VoidCallback onMenuPressed;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _storageService = SecureStorageService();
  String doctorName = '';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    final user = await _storageService.getUserData();
    setState(() {
      doctorName = user?.doctorName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.primary,
      title: Text(
        '${context.l10n.welcome}, $doctorName',
        style: AppTextStyles().titleMediumTextStyle(
          context: context,
          textColor: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded, size: 30),
        color: Colors.white,
        onPressed: widget.onMenuPressed,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, size: 30),
          color: Colors.white,
          onPressed: () async {
            AppNavigation().navigateToSetting(context: context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout_rounded, size: 30),
          color: Colors.white,
          onPressed: () async {
            await _storageService.clearUserData().whenComplete(() {
              if (context.mounted) {
                AppNavigation().navigateToSignIn(context: context);
              }
            });
          },
        ),
      ],
    );
  }
}
