part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

final class RegisterInitialState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterLoadedState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterErrorState extends RegisterState {
  const RegisterErrorState({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
