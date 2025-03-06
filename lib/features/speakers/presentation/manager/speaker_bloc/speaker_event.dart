part of 'speaker_bloc.dart';

sealed class SpeakerEvent extends Equatable {
  const SpeakerEvent();
}

final class FetchSpeakers extends SpeakerEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
