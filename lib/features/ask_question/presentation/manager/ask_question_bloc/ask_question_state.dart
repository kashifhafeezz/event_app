part of 'ask_question_bloc.dart';

sealed class AskQuestionState extends Equatable {
  const AskQuestionState();
}

final class AskQuestionInitialState extends AskQuestionState {
  @override
  List<Object?> get props => [];
}

final class AskQuestionLoadingState extends AskQuestionState {
  @override
  List<Object?> get props => [];
}

final class AskQuestionLoadedState extends AskQuestionState {
  @override
  List<Object?> get props => [];
}

final class AskQuestionErrorState extends AskQuestionState {
  const AskQuestionErrorState({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
