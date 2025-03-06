import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';
import 'package:event_app/features/ask_question/domain/repositories/ask_question_repository.dart';

class AskQuestionUsecase extends UseCase<bool, AskQuestionRequestModel> {
  AskQuestionUsecase({required this.askQuestionRepository});
  final AskQuestionRepository askQuestionRepository;

  @override
  Future<Either<ResponseError, bool>> call(
    AskQuestionRequestModel params,
  ) async {
    return askQuestionRepository.askQuestion(params: params);
  }
}
