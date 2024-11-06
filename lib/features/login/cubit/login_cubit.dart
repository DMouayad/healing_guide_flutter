import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/login/login_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : formHelper = LoginFormHelper(),
        super(const LoginIdleState());

  final LoginFormHelper formHelper;

  Future<void> onLoginRequested() async {
    if (!formHelper.validateInput()) {
      return;
    }
    emit(const LoginBusyState());
    try {
      await GetIt.I.get<AuthRepository>().logIn(UserLoginDTO(
            password: formHelper.passwordValue,
            email: formHelper.emailValue,
          ));
      emit(const LoginSuccessState());
    } catch (e) {
      AppException appException =
          e is AppException ? e : AppException.undefined;
      emit(LoginFailureState(appException));
    } finally {
      if (state.isBusy) {
        emit(const LoginIdleState());
      }
    }
  }
}
