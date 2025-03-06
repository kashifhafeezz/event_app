import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:event_app/features/Home/presentation/manager/theme_cubit/theme_cubit.dart'
    as theme;
import 'package:event_app/utils/di/di_container.dart';
import 'package:event_app/utils/navigation/app_router_navigation_delegate.dart';
import 'package:event_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late LocaleCubit localeCubit;
  late theme.ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    localeCubit = di.get<LocaleCubit>();
    themeCubit = di.get<theme.ThemeCubit>();
  }

  @override
  void dispose() {
    localeCubit.close();
    themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: localeCubit),
        BlocProvider.value(value: themeCubit),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<theme.ThemeCubit, theme.ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: AppRouterNavigationDelegate.router,
                theme: AppTheme().lightTheme,
                darkTheme: AppTheme().darkTheme,
                themeMode: themeState.themeMode == theme.ThemeMode.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                locale: Locale(localeState.languageCode),
              );
            },
          );
        },
      ),
    );
  }
}
