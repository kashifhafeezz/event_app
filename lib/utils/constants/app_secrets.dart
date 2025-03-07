import 'package:envied/envied.dart';
part 'app_secrets.g.dart';

@Envied(path: '.env')
abstract class AppSecrets {
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static String apiBaseUrl = _AppSecrets.apiBaseUrl;
}
