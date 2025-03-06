import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/features/speakers/domain/usecases/speaker_usecase.dart';
part 'speaker_event.dart';
part 'speaker_state.dart';

class SpeakerBloc extends Bloc<SpeakerEvent, SpeakerState> {
  SpeakerBloc({required this.usecase})
      : super(const SpeakerInitialState(speakerList: [])) {
    on<FetchSpeakers>(_fetchSpeakers);
  }
  final SpeakerUsecase usecase;

  Future<void> _fetchSpeakers(
    FetchSpeakers event,
    Emitter<SpeakerState> emit,
  ) async {
    emit(const SpeakerLoadingState(speakerList: []));

    final response = await usecase.call(NoParams());

    response.fold(
      (error) {
        emit(
          SpeakerErrorState(
            speakerList: const [],
            errorMessage: error.errorStatus,
          ),
        );
      },
      (success) {
        log('Speaker Bloc $success');
        emit(SpeakerLoadedState(speakerList: success));
      },
    );
  }
}
