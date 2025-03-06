part of 'speaker_bloc.dart';

sealed class SpeakerState extends Equatable {
  const SpeakerState({required this.speakerList});
  final List<SpeakerModel> speakerList;
}

final class SpeakerInitialState extends SpeakerState {
  const SpeakerInitialState({required super.speakerList});

  @override
  List<Object?> get props => [super.speakerList];
}

final class SpeakerLoadingState extends SpeakerState {
  const SpeakerLoadingState({required super.speakerList});

  @override
  List<Object?> get props => [super.speakerList];
}

final class SpeakerLoadedState extends SpeakerState {
  const SpeakerLoadedState({required super.speakerList});

  @override
  List<Object?> get props => [super.speakerList];
}

final class SpeakerErrorState extends SpeakerState {
  const SpeakerErrorState({
    required super.speakerList,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [super.speakerList, errorMessage];
}
