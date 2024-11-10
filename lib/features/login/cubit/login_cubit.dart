import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/login/login_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginFormHelper formHelper;
  late final BlocHelpers _helpers;

  LoginCubit()
      : formHelper = LoginFormHelper(),
        super(const LoginIdleState()) {
    _helpers = BlocHelpers(
      onError: (exception) => emit(LoginFailureState(exception)),
      setBusyTrue: () => emit(const LoginBusyState()),
      setBusyFalse: () => emit(const LoginIdleState()),
      isBusy: () => state.isBusy,
    );
  }

  Future<void> onLoginRequested() async {
    if (!formHelper.validateInput() || state.isBusy) {
      return;
    }
    _helpers.handleFuture(
      GetIt.I.get<AuthRepository>().logIn(UserLoginDTO(
            password: formHelper.passwordValue,
            email: formHelper.emailValue,
          )),
      onSuccess: (_) => emit(const LoginSuccessState()),
    );
  }
}
