import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/features/Home/view/home_screen.dart';
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
  static final _storageService = SecureStorageService();
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteNames().initialRoute,
    // Add the redirect logic here
    redirect: (context, state) async {
      // Don't redirect on the splash screen
      if (state.fullPath == AppRouteNames().initialRoute) {
        return null;
      }

      // Check if user is logged in
      final isLoggedIn = await _storageService.isUserLoggedIn();

      // If not logged in and not on auth screen, redirect to login
      final isGoingToAuth = state.fullPath == AppRouteNames().signInRoute ||
          state.fullPath == AppRouteNames().signUpRoute;

      if (!isLoggedIn && !isGoingToAuth) {
        return AppRouteNames().signInRoute;
      }

      // If logged in and going to auth screen, redirect to home
      if (isLoggedIn && isGoingToAuth) {
        return AppRouteNames().homeRoute;
      }

      // No redirect needed
      return null;
    },
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
          child: const HomeScreen(),
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
