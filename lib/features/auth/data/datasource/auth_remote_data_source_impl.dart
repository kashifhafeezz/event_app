import 'dart:developer';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/contants/api_routes.dart';

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImplementation({required this.client});
  final ApiClient client;

  @override
  Future<bool> register({required RegisterRequestModel params}) async {
    log('PARAMS ${params.toJson()}');
    try {
      final response = await client.request(
        path: ApiRoutes().register,
        method: HttpMethod.post,
        data: params.toJson(),
      );

      if (response.isSuccess) {
        log('Success: ${response.message}');
        log('User Data: ${response.data}');
        return true;
      } else {
        log('Error: ${response.message}');
        log('Status Code: ${response.statusCode}');
        throw ResponseError(errorStatus: response.message.toString());
      }
    } on ResponseError catch (e) {
      log('Registration Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error during registration: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }

  @override
  Future<LoginResponseModel> login({required LoginRequestModel params}) async {
    log('PARAMS ${params.toJson()}');
    try {
      final response = await client.request(
        path: ApiRoutes().login,
        method: HttpMethod.post,
        data: params.toJson(),
      );

      if (response.isSuccess) {
        log('Success: ${response.message}');
        log('User Data: ${response.data}');

        final data = response.data as Map<String, dynamic>;
        final model = LoginResponseModel.fromJson(data);

        return model;
      } else {
        log('Error: ${response.message}');
        log('Status Code: ${response.statusCode}');
        throw ResponseError(errorStatus: response.message.toString());
      }
    } on ResponseError catch (e) {
      log('Login Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error during login: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }
}
