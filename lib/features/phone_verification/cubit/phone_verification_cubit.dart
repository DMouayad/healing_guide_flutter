import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/phone_verification/repositories.dart';
import 'package:healing_guide_flutter/features/signup/cubit/signup_cubit.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';

part 'phone_verification_state.dart';

const kVerificationCodeRequestInterval = Duration(minutes: 15);
const kValidVerificationCode = '0000';

class PhoneVerificationCubit extends Cubit<PhoneVerificationState> {
  late final BlocHelpers _helpers;
  PhoneVerificationCubit()
      : super(
          PhoneVerificationUserInputState(
            digits: Map.fromIterable([0, 1, 2, 3], value: (_) => null),
            lastRequestedCodeAt: DateTime.now(),
          ),
        ) {
    _helpers = BlocHelpers(
      onError: (exception) => emit(PhoneVerificationFailureState(
        appException: exception,
        digits: state.digits,
        lastRequestedCodeAt: state.lastRequestedCodeAt,
      )),
      setBusyTrue: () => emit(PhoneVerificationInProgressState(
        digits: state.digits,
        lastRequestedCodeAt: state.lastRequestedCodeAt,
      )),
      setBusyFalse: () => emit(PhoneVerificationUserInputState(
        digits: state.digits,
        lastRequestedCodeAt: state.lastRequestedCodeAt,
      )),
      isBusy: () => state.isBusy,
    );
  }

  void onVerificationCodeDigitChanged(int digit, String value) {
    if (digit > 3) {
      return;
    }
    final newDigits = Map<int, int?>.from(state.digits);
    newDigits[digit] = int.tryParse(value);
    emit(PhoneVerificationUserInputState(
      digits: newDigits,
      lastRequestedCodeAt: state.lastRequestedCodeAt,
    ));
  }

  void onSubmitCode(SignupPendingPhoneVerificationState signupState) {
    if (state.inputIsValid()) {
      _helpers.handleFuture(
        GetIt.I
            .get<ApiPhoneVerificationRepository>()
            .verify(signupState.dto.phoneNumber, signupState.dto.role),
        onSuccess: (_) => emit(PhoneVerificationSuccessState(
            lastRequestedCodeAt: state.lastRequestedCodeAt)),
      );
    }
  }

  void onNewCodeRequested() {
    emit(PhoneVerificationInProgressState(
      digits: state.digits,
      lastRequestedCodeAt: DateTime.now(),
    ));
    Timer(const Duration(seconds: 1), () {
      emit(PhoneVerificationUserInputState(
        digits: state.digits,
        lastRequestedCodeAt: state.lastRequestedCodeAt,
      ));
    });
  }
}
