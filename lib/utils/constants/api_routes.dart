class ApiRoutes {
  factory ApiRoutes() => _singleton;
  ApiRoutes._internal();
  static final ApiRoutes _singleton = ApiRoutes._internal();

  String baseUrl = 'https://ldb-me.ve-live.com/api/AdminApiProvider';
  String login = '/UserLogin';
  String register = '/RegisterUser';
  String agenda = '/LoadAgenda';
  String speakers = '/LoadSpeakers';
  String askQuestion = '/AskQuestion';
}
