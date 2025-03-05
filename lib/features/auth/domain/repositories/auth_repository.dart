import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';

abstract class AuthRepository {
  Future<Either<ResponseError, bool>> register({
    required RegisterRequestModel params,
  });

  Future<Either<ResponseError, LoginResponseModel>> login({
    required LoginRequestModel params,
  });
}
