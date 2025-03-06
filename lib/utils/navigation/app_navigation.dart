import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/utils/extension/string_extenstion.dart';
import 'package:event_app/utils/navigation/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  factory AppNavigation() => _singleton;

  AppNavigation._internal();

  static final AppNavigation _singleton = AppNavigation._internal();

  final _routeNames = AppRouteNames();

  void navigateBack({required BuildContext context, dynamic data}) {
    context.pop(data);
  }

  void navigateToSignIn({required BuildContext context}) {
    context.goNamed(_routeNames.signInRoute.convertRouteToName);
  }

  void navigateToSignUp({required BuildContext context}) {
    context.pushNamed(_routeNames.signUpRoute.convertRouteToName);
  }

  void navigateToHome({required BuildContext context}) {
    context.goNamed(_routeNames.homeRoute.convertRouteToName);
  }

  void navigateToFeatureScreen({
    required BuildContext context,
    required String route,
  }) {
    if (route.isNotEmpty) {
      context.pushNamed(route.convertRouteToName);
    }
  }

  void navigateToSpeakerDetailScreen({
    required BuildContext context,
    required SpeakerModel speakerModel,
  }) {
    context.pushNamed(
      _routeNames.speakerDetailRoute.convertRouteToName,
      extra: speakerModel,
    );
  }
}
