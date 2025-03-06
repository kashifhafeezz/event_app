import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/ask_question/data/datasource/ask_question_remote_data_source.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';
import 'package:event_app/features/ask_question/domain/repositories/ask_question_repository.dart';

class AskQuestionRepositoryImpl extends AskQuestionRepository {
  AskQuestionRepositoryImpl({required this.askQuestionRemoteDataSource});
  final AskQuestionRemoteDataSource askQuestionRemoteDataSource;

  @override
  Future<Either<ResponseError, bool>> askQuestion({
    required AskQuestionRequestModel params,
  }) async {
    try {
      final response =
          await askQuestionRemoteDataSource.askQuestion(params: params);

      return response
          ? Right(response)
          : Left(ResponseError(errorStatus: 'Request failed'));
    } on ResponseError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ResponseError(errorStatus: 'Unexpected error'),
      );
    }
  }
}
