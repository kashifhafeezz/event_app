import 'dart:developer';

import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/ask_question/data/datasource/ask_question_remote_data_source.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';

class AskQuestionRemoteDataSourceImpl implements AskQuestionRemoteDataSource {
  const AskQuestionRemoteDataSourceImpl({required this.client});
  final ApiClient client;

  @override
  Future<bool> askQuestion({required AskQuestionRequestModel params}) async {
    try {
      final response = await client.request(
        path: ApiRoutes().askQuestion,
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
      log('Ask Question Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error occurred: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }
}
