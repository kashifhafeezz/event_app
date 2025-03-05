import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> register({required RegisterRequestModel params});
  Future<LoginResponseModel> login({required LoginRequestModel params});
}

// kashif@hafeez.com , 123456
