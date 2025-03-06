import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/ask_question/data/models/request_model/ask_question_request_model.dart';
import 'package:event_app/features/ask_question/domain/usecases/ask_question_usecase.dart';
part 'ask_question_event.dart';
part 'ask_question_state.dart';

class AskQuestionBloc extends Bloc<AskQuestionEvent, AskQuestionState> {
  AskQuestionBloc({required this.usecase}) : super(AskQuestionInitialState()) {
    on<SubmitQuestionEvent>(_askQuestion);
  }

  final AskQuestionUsecase usecase;

  Future<void> _askQuestion(
    SubmitQuestionEvent event,
    Emitter<AskQuestionState> emit,
  ) async {
    emit(AskQuestionLoadingState());

    final response = await usecase.call(event.requestModel);

    response.fold(
      (error) {
        log('Bloc Question Left ${error.errorStatus}');

        emit(AskQuestionErrorState(errorMessage: error.errorStatus));
      },
      (success) {
        log('Bloc Question Right $success');
        emit(AskQuestionLoadedState());
      },
    );
  }
}
