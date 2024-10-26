import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/login/login_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginIdleState()) {
    formHelper = LoginFormHelper();
  }
  final AuthRepository _authRepository;
  late final LoginFormHelper formHelper;

  Future<void> onLoginRequested() async {
    if (!formHelper.validateInput()) {
      return;
    }
    emit(LoginBusyState());
    try {
      await _authRepository.logIn(UserLoginDTO(
        password: formHelper.passwordValue,
        phoneNumber: formHelper.phoneNoValue,
      ));
      emit(LoginSuccessState());
    } catch (e) {
      AppException appException =
          e is AppException ? e : AppException.undefined;
      emit(LoginFailureState(appException));
    } finally {
      if (state.isBusy) {
        emit(LoginIdleState());
      }
    }
  }
}