import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/signup/signup_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  late final SignupFormHelper formHelper;
  late final BlocHelpers _helpers;
  final Role signupAs;

  AuthRepository get _authRepo => GetIt.I.get();

  SignupCubit({required this.signupAs}) : super(const SignupIdleState()) {
    formHelper = SignupFormHelper();
    _helpers = BlocHelpers(
      onError: (exception) => emit(SignupFailureState(exception)),
      setBusyTrue: () => emit(const SignupBusyState()),
      setBusyFalse: () => emit(const SignupIdleState()),
      isBusy: () => state.isBusy,
    );
  }

  Future<void> onSignupFormSubmit() async {
    if (!formHelper.validateInput() || state.isBusy) {
      return;
    }

    final dto = StartRegistrationDTO(
      role: signupAs,
      email: formHelper.emailValue,
      phoneNumber: formHelper.phoneNoValue,
      password: formHelper.passwordValue,
    );
    _helpers.handleFuture(
      _authRepo.startRegistration(dto),
      onSuccess: (value) {
        //  userRepository.sendEmailVerificationCode(dto.phoneNumber);
        Timer(
          const Duration(seconds: 2),
          () => emit(SignupPendingPhoneVerificationState(
            email: formHelper.emailValue,
            password: formHelper.passwordValue,
            phoneNumber: formHelper.phoneNoValue,
          )),
        );
      },
    );
  }

  Future<void> proceedToSecondStep() async {
    final currentState = state;
    if (currentState is! SignupPendingPhoneVerificationState) {
      pLogger.w(
        '($runtimeType) Error: signup requested but current state type is not correct',
      );
      return;
    }
    emit(CompleteSignupState.fromPendingState(currentState));
  }

  Future<void> onCompleteSignupRequested() async {
    if (!formHelper.validateInput() || state.isBusy) {
      return;
    }
    final dto = CompleteRegistrationDTO(
      role: signupAs,
      password: formHelper.passwordValue,
      phoneNumber: formHelper.phoneNoValue,
      email: formHelper.emailValue,
      fullName: formHelper.fullNameValue,
    );
    _helpers.handleFuture(
      GetIt.I.get<AuthRepository>().completeRegistration(dto),
      onSuccess: (_) => emit(const SignupSuccessState()),
    );
  }
}
