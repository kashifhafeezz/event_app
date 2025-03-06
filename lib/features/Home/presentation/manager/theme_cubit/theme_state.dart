part of 'theme_cubit.dart';

enum ThemeMode { light, dark }

class ThemeState extends Equatable {
  const ThemeState({required this.themeMode});

  factory ThemeState.initial() => const ThemeState(themeMode: ThemeMode.light);

  final ThemeMode themeMode;

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object> get props => [themeMode];
}
