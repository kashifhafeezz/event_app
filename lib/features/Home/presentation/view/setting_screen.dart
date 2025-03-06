import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:event_app/features/Home/presentation/manager/theme_cubit/theme_cubit.dart'
    as theme;
import 'package:event_app/utils/common/app_drawer_widget.dart';
import 'package:event_app/utils/common/app_header_widget.dart';
import 'package:event_app/utils/common/common_app_bar.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawerWidget(),
      appBar: CommonAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeaderWidget(),
            const SizedBox(height: 40),
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                final isArabicLang =
                    state.languageCode == SupportedLanguageLocales.arabicLocale;
                return ListTile(
                  title: Text(
                    '${context.l10n.language} (${isArabicLang ? 'عربي' : 'English'})',
                    style: AppTextStyles()
                        .titleSmallTextStyle(context: context)
                        ?.copyWith(fontWeight: AppFontWeight().medium),
                  ),
                  trailing: Switch(
                    value: isArabicLang,
                    onChanged: (v) {
                      context.read<LocaleCubit>().toggleApplicationLanguage(
                            languageCode: v
                                ? SupportedLanguageLocales.arabicLocale
                                : SupportedLanguageLocales.engLangCode,
                          );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            BlocBuilder<theme.ThemeCubit, theme.ThemeState>(
              builder: (context, state) {
                final isDarkTheme = state.themeMode == theme.ThemeMode.dark;
                return ListTile(
                  title: Text(
                    '${context.l10n.theme} (${isDarkTheme ? context.l10n.dark_theme : context.l10n.light_theme})',
                    style: AppTextStyles()
                        .titleSmallTextStyle(context: context)
                        ?.copyWith(fontWeight: AppFontWeight().medium),
                  ),
                  trailing: Switch(
                    value: isDarkTheme,
                    onChanged: (v) {
                      context.read<theme.ThemeCubit>().changeTheme(
                            v ? theme.ThemeMode.dark : theme.ThemeMode.light,
                          );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
