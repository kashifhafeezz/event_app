import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/constants/app_utils.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 8),
            child: Assets.images.lldd.image(
              height: 80,
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            leading: const Icon(Icons.home, size: 25),
            title: Text(
              context.l10n.home,
              style: AppTextStyles()
                  .titleMediumTextStyle(context: context)
                  ?.copyWith(fontWeight: AppFontWeight().regular),
            ),
            onTap: () {
              AppNavigation().navigateBack(context: context);
              AppNavigation().navigateToHome(context: context);
            },
          ),
          ListView.builder(
            itemCount: AppUtils().homeViewModelList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = AppUtils().homeViewModelList[index];
              return ListTile(
                leading: Icon(item.iconData, size: 25),
                title: Text(
                  item.title,
                  style: AppTextStyles()
                      .titleMediumTextStyle(context: context)
                      ?.copyWith(fontWeight: AppFontWeight().regular),
                ),
                onTap: () {
                  AppNavigation().navigateToFeatureScreen(
                    context: context,
                    route: item.route,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
