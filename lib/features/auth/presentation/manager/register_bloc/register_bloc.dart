import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/auth/data/models/request_model/register_request_model.dart';
import 'package:event_app/features/auth/domain/usecases/register_usecase.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.registerUsecase})
      : super(RegisterInitialState()) {
    on<RegisterUserEvent>(_registerUser);
  }

  final RegisterUsecase registerUsecase;

  Future<void> _registerUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoadingState());
    final response = await registerUsecase.call(event.requestModel);
    response.fold(
      (error) {
        log('Bloc ${error.errorStatus}');

        emit(RegisterErrorState(errorMessage: error.errorStatus));
      },
      (success) {
        log('Bloc $success');
        emit(RegisterLoadedState());
      },
    );
  }
}
