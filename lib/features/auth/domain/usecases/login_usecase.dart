import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:event_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends UseCase<LoginResponseModel, LoginRequestModel> {
  LoginUsecase({required this.repo});
  final AuthRepository repo;

  @override
  Future<Either<ResponseError, LoginResponseModel>> call(
    LoginRequestModel params,
  ) async {
    return repo.login(params: params);
  }
}
