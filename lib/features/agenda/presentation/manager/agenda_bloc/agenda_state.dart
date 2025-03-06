part of 'agenda_bloc.dart';

sealed class AgendaState extends Equatable {
  const AgendaState({required this.agendaList});
  final List<AgendaModel> agendaList;
}

final class AgendaInitialState extends AgendaState {
  const AgendaInitialState({required super.agendaList});

  @override
  List<Object?> get props => [super.agendaList];
}

final class AgendaLoadingState extends AgendaState {
  const AgendaLoadingState({required super.agendaList});

  @override
  List<Object?> get props => [super.agendaList];
}

final class AgendaLoadedState extends AgendaState {
  const AgendaLoadedState({required super.agendaList});

  @override
  List<Object?> get props => [super.agendaList];
}

final class AgendaErrorState extends AgendaState {
  const AgendaErrorState({
    required super.agendaList,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [super.agendaList, errorMessage];
}
