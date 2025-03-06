class AppRouteNames {
  factory AppRouteNames() => _singleton;
  AppRouteNames._internal();
  static final AppRouteNames _singleton = AppRouteNames._internal();

  final String initialRoute = '/splash-screen';

  final String signInRoute = '/sign-in-screen';

  final String signUpRoute = '/sign-up-screen';

  final String homeRoute = '/home-screen';

  final String agendaRoute = '/agenda-screen';

  final String badgeRoute = '/badge-screen';

  final String askQuestionRoute = '/ask-question-screen';

  final String speakerListingRoute = '/speaker-listing-screen';

  final String speakerDetailRoute = '/speaker-detail-screen';

  final String settingRoute = '/setting-screen';
}
