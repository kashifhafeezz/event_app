import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    localeCubit = di.get<LocaleCubit>();
  }

  @override
  void dispose() {
    localeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: localeCubit),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouterNavigationDelegate.router,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            themeMode: ThemeMode.light,
            locale: Locale(localeState.languageCode),
          );
        },
      ),
    );
  }
}
