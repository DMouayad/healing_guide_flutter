import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/signup/signup_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

part 'signup_state.dart';

class SignupCubit extends HydratedCubit<SignupState> {
  late final SignupFormHelper formHelper;
  late final BlocHelpers _helpers;
  final Role signupAs;

  AuthRepository get _authRepo => GetIt.I.get();

  SignupCubit({
    required this.signupAs,
  }) : super(const SignupIdleState()) {
    formHelper = SignupFormHelper();
    _helpers = BlocHelpers(
      onError: (exception) => emit(state.copyWithException(exception)),
      setBusyTrue: () => emit(state.copyWithBusy(isBusy: true)),
      setBusyFalse: () => emit(state.copyWithBusy(isBusy: false)),
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
        final state = SignupPendingPhoneVerificationState(dto);
        Timer(const Duration(seconds: 2), () => emit(state));
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
    emit(SignupPendingCompletionState(currentState.dto));
  }

  Future<void> onCompleteSignupRequested() async {
    if (!formHelper.validateInput() || state.isBusy) {
      return;
    }
    if (signupAs == Role.patient) {
      final dto = CompletePatientRegistrationDTO(
        email: formHelper.emailValue,
        phoneNumber: formHelper.phoneNoValue,
        fullName: formHelper.fullNameValue,
        password: formHelper.passwordValue,
      );
      _helpers.handleFuture(
        GetIt.I.get<AuthRepository>().completePatientRegistration(dto),
        onSuccess: (_) => emit(const SignupSuccessState()),
      );
    } else if (signupAs == Role.physician) {
      final dto = CompletePhysicianRegistrationDTO(
        password: formHelper.passwordValue,
        phoneNumber: formHelper.phoneNoValue,
        email: formHelper.emailValue,
        fullName: formHelper.fullNameValue,
        biography: faker.lorem.sentences(2).join("\n"),
        location: faker.address.city(),
        languages: const ['English'],
      );
      _helpers.handleFuture(
        GetIt.I.get<AuthRepository>().completePhysicianRegistration(dto),
        onSuccess: (_) => emit(const SignupSuccessState()),
      );
    }
  }

  @override
  SignupState? fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "step": String step,
          "dto": Map<String, dynamic> dtoJson,
        }) {
      if (StartRegistrationDTO.fromJson(dtoJson)
          case StartRegistrationDTO dto) {
        if (step == SignupPendingCompletionState.stepName) {
          return SignupPendingCompletionState(dto);
        }
        if (step == SignupPendingPhoneVerificationState.stepName) {
          return SignupPendingPhoneVerificationState(dto);
        }
      }
    }
    return const SignupIdleState();
  }

  @override
  Map<String, dynamic>? toJson(SignupState state) {
    var json = state.toJson();
    return json;
  }
}
