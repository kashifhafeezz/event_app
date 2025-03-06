part of 'ask_question_bloc.dart';

sealed class AskQuestionEvent extends Equatable {
  const AskQuestionEvent();
}

final class SubmitQuestionEvent extends AskQuestionEvent {
  const SubmitQuestionEvent({required this.requestModel});
  final AskQuestionRequestModel requestModel;

  @override
  List<Object?> get props => [requestModel];
}
