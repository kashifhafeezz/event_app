import 'package:event_app/features/auth/presentation/view/sign_in_screen.dart';
import 'package:event_app/features/auth/presentation/view/sign_up_screen.dart';
import 'package:event_app/features/auth/presentation/view/splash_screen.dart';
import 'package:event_app/utils/extension/string_extenstion.dart';
import 'package:event_app/utils/navigation/app_page_transition_builder.dart';
import 'package:event_app/utils/navigation/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterNavigationDelegate {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteNames().initialRoute,
    routes: [
      GoRoute(
        path: AppRouteNames().initialRoute,
        name: AppRouteNames().initialRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouteNames().signInRoute,
        name: AppRouteNames().signInRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().signUpRoute,
        name: AppRouteNames().signUpRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().homeRoute,
        name: AppRouteNames().homeRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().agendaRoute,
        name: AppRouteNames().agendaRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().badgeRoute,
        name: AppRouteNames().badgeRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().askQuestionRoute,
        name: AppRouteNames().askQuestionRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().speakerListingRoute,
        name: AppRouteNames().speakerListingRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().speakerDetailRoute,
        name: AppRouteNames().speakerDetailRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const Scaffold(),
        ),
      ),
    ],
  );
}
