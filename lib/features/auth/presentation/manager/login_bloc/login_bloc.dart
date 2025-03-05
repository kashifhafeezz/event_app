import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:event_app/features/auth/domain/usecases/login_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUsecase})
      : super(
          LoginInitialState(
            loginResponseModel: LoginResponseModel(
              id: 0,
              userUniqueId: '',
              qrCode: '',
              doctorName: '',
              email: '',
            ),
          ),
        ) {
    on<LoginUserEvent>(_loginUser);
  }

  Future<void> _loginUser(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginLoadingState(
        loginResponseModel: LoginResponseModel(
          id: 0,
          userUniqueId: '',
          qrCode: '',
          doctorName: '',
          email: '',
        ),
      ),
    );

    final response = await loginUsecase.call(event.requestModel);
    response.fold(
      (error) {
        log('Login Bloc ${error.errorStatus}');

        emit(
          LoginErrorState(
            loginResponseModel: LoginResponseModel(
              id: 0,
              userUniqueId: '',
              qrCode: '',
              doctorName: '',
              email: '',
            ),
            errorMessage: error.errorStatus,
          ),
        );
      },
      (success) {
        log('Login Bloc $success');
        emit(LoginLoadedState(loginResponseModel: success));
      },
    );
  }

  final LoginUsecase loginUsecase;
}
