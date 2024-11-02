import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/signup/signup_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends HydratedCubit<SignupState> {
  late final AuthRepository _authRepository;
  late final SignupFormHelper formHelper;
  final Role signupAs;

  SignupCubit({required this.signupAs, required AuthRepository authRepository})
      : super(const SignupIdleState()) {
    formHelper = SignupFormHelper(
      emailInitialValue: state.dto?.email,
      fullNameInitialValue: state.dto?.fullName,
      phoneInitialValue: state.dto?.phoneNumber,
    );
    _authRepository = authRepository;
  }
  void onSignupFormSubmit() {
    if (!formHelper.validateInput()) {
      return;
    }
    final dto = UserRegistrationDTO(
      role: signupAs,
      password: formHelper.passwordValue,
      phoneNumber: formHelper.phoneNoValue,
      email: formHelper.emailValue,
      fullName: formHelper.fullNameValue,
    );
    emit(const SignupBusyState());
    //
    // await userRepository.sendEmailVerificationCode(dto.phoneNumber);
    Timer(const Duration(seconds: 2),
        () => emit(SignupPendingPhoneVerificationState(dto: dto)));
  }

  Future<void> onSignupRequestedAfterVerification() async {
    final currentState = state;
    if (currentState is! SignupPendingPhoneVerificationState) {
      pLogger.w(
        '($runtimeType) Error: signup requested but current state type is not correct',
      );
      return;
    }
    emit(const SignupBusyState());
    try {
      await _authRepository.register(currentState.dto);
      emit(const SignupSuccessState());
    } catch (e) {
      AppException appException =
          e is AppException ? e : AppException.undefined;
      emit(SignupFailureState(appException));
    } finally {
      if (state.isBusy) {
        emit(const SignupIdleState());
      }
    }
  }

  @override
  SignupState? fromJson(Map<String, dynamic> json) {
    final dto = UserRegistrationDTO.fromJson(json["dto"]);
    if (dto != null) {
      return SignupPendingPhoneVerificationState(dto: dto);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(SignupState state) {
    if (state is SignupPendingPhoneVerificationState) {
      return {"dto": state.dto.toJson()};
    }
    return null;
  }
}
