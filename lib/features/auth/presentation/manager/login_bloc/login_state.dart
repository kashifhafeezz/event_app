part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState({required this.loginResponseModel});

  final LoginResponseModel loginResponseModel;
}

final class LoginInitialState extends LoginState {
  const LoginInitialState({required super.loginResponseModel});

  @override
  List<Object?> get props => [super.loginResponseModel];
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState({required super.loginResponseModel});

  @override
  List<Object?> get props => [super.loginResponseModel];
}

final class LoginLoadedState extends LoginState {
  const LoginLoadedState({required super.loginResponseModel});

  @override
  List<Object?> get props => [super.loginResponseModel];
}

final class LoginErrorState extends LoginState {
  const LoginErrorState({
    required super.loginResponseModel,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [super.loginResponseModel, errorMessage];
}
