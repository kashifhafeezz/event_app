import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/features/agenda/domain/usecases/agenda_usecase.dart';
part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc({required this.usecase})
      : super(const AgendaInitialState(agendaList: [])) {
    on<FetchAgenda>(_getAgenda);
  }

  final AgendaUsecase usecase;

  Future<void> _getAgenda(
    AgendaEvent event,
    Emitter<AgendaState> emit,
  ) async {
    emit(const AgendaLoadingState(agendaList: []));

    final response = await usecase.call(NoParams());

    response.fold(
      (error) {
        emit(
          AgendaErrorState(
            agendaList: const [],
            errorMessage: error.errorStatus,
          ),
        );
      },
      (success) {
        log('Agenda Bloc $success');
        emit(AgendaLoadedState(agendaList: success));
      },
    );
  }
}
