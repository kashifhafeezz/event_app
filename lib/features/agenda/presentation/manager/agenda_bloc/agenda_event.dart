part of 'agenda_bloc.dart';

sealed class AgendaEvent extends Equatable {
  const AgendaEvent();
}

final class FetchAgenda extends AgendaEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
