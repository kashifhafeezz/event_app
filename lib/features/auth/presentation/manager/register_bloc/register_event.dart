part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

final class RegisterUserEvent extends RegisterEvent {
  const RegisterUserEvent({required this.requestModel});
  final RegisterRequestModel requestModel;

  @override
  List<Object?> get props => [requestModel];
}
