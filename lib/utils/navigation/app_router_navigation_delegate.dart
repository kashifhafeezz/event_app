import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/features/Badge/presentation/view/badge_screen.dart';
import 'package:event_app/features/Home/presentation/view/home_screen.dart';
import 'package:event_app/features/Home/presentation/view/setting_screen.dart';
import 'package:event_app/features/agenda/presentation/view/agenda_screen.dart';
import 'package:event_app/features/ask_question/presentation/view/ask_question_screen.dart';
import 'package:event_app/features/auth/presentation/view/sign_in_screen.dart';
import 'package:event_app/features/auth/presentation/view/sign_up_screen.dart';
import 'package:event_app/features/auth/presentation/view/splash_screen.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/features/speakers/presentation/view/speaker_detail_screen.dart';
import 'package:event_app/features/speakers/presentation/view/speaker_listing_screen.dart';
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
    // Checking If User Login, Navigate to Home screen other wise navigate to Login screen
    redirect: (context, state) async {
      if (state.fullPath == AppRouteNames().initialRoute) {
        return null;
      }

      final isLoggedIn = await _storageService.isUserLoggedIn();

      final isGoingToAuth = state.fullPath == AppRouteNames().signInRoute ||
          state.fullPath == AppRouteNames().signUpRoute;

      if (!isLoggedIn && !isGoingToAuth) {
        return AppRouteNames().signInRoute;
      }

      if (isLoggedIn && isGoingToAuth) {
        return AppRouteNames().homeRoute;
      }

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
          child: const AgendaScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().badgeRoute,
        name: AppRouteNames().badgeRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const BadgeScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().askQuestionRoute,
        name: AppRouteNames().askQuestionRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const AskQuestionScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().speakerListingRoute,
        name: AppRouteNames().speakerListingRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const SpeakerListingScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteNames().speakerDetailRoute,
        name: AppRouteNames().speakerDetailRoute.convertRouteToName,
        pageBuilder: (context, state) {
          final model = state.extra! as SpeakerModel;
          return PageTransitionBuilder.transition(
            pageKey: state.pageKey,
            child: SpeakerDetailScreen(speakerModel: model),
          );
        },
      ),
      GoRoute(
        path: AppRouteNames().settingRoute,
        name: AppRouteNames().settingRoute.convertRouteToName,
        pageBuilder: (context, state) => PageTransitionBuilder.transition(
          pageKey: state.pageKey,
          child: const SettingScreen(),
        ),
      ),
    ],
  );
}
