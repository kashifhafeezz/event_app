import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase extends UseCase<bool, RegisterRequestModel> {
  RegisterUsecase({required this.repo});
  final AuthRepository repo;

  @override
  Future<Either<ResponseError, bool>> call(RegisterRequestModel params) async {
    return repo.register(params: params);
  }
}
