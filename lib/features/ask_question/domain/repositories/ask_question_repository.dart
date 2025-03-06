import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';

abstract class AskQuestionRepository {
  Future<Either<ResponseError, bool>> askQuestion({
    required AskQuestionRequestModel params,
  });
}
