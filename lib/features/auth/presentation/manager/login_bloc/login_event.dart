part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginUserEvent extends LoginEvent {
  const LoginUserEvent({required this.requestModel});
  final LoginRequestModel requestModel;

  @override
  List<Object?> get props => [requestModel];
}
