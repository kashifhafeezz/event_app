import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';

abstract class AskQuestionRemoteDataSource {
  Future<bool> askQuestion({required AskQuestionRequestModel params});
}
