part of 'locale_cubit.dart';

sealed class LocaleState extends Equatable {
  const LocaleState({
    required this.languageCode,
  });

  final String languageCode;
}

final class ToggleAppLocaleState extends LocaleState {
  const ToggleAppLocaleState({required super.languageCode});

  @override
  List<Object> get props => [super.languageCode];
}
