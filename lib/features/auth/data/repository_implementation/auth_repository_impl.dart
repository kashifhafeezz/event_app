import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:event_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.storageService,
  });
  final AuthRemoteDataSource authRemoteDataSource;
  final SecureStorageService storageService;

  @override
  Future<Either<ResponseError, bool>> register({
    required RegisterRequestModel params,
  }) async {
    try {
      final response = await authRemoteDataSource.register(params: params);

      return response
          ? Right(response)
          : Left(ResponseError(errorStatus: 'Registration failed'));
    } on ResponseError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ResponseError(errorStatus: 'Unexpected error during registration'),
      );
    }
  }

  @override
  Future<Either<ResponseError, LoginResponseModel>> login({
    required LoginRequestModel params,
  }) async {
    try {
      final response = await authRemoteDataSource.login(params: params);
      // Store user data in secure storage when login is successful
      await storageService.saveUserData(response);
      return Right(response);
    } on ResponseError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ResponseError(errorStatus: 'Unexpected error during login'));
    }
  }
}
