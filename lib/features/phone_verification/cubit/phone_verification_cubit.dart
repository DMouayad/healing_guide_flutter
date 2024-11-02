import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';

part 'phone_verification_state.dart';

const kVerificationCodeRequestInterval = Duration(minutes: 15);
const kValidVerificationCode = '0000';

class PhoneVerificationCubit extends Cubit<PhoneVerificationState> {
  PhoneVerificationCubit()
      : super(PhoneVerificationUserInputState(
          digits: Map.fromIterable([0, 1, 2, 3], value: (_) => null),
          lastRequestedCodeAt: DateTime.now(),
        ));

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

  void onSubmitCode() {
    if (state.inputIsValid()) {
      emit(PhoneVerificationInProgressState(
        digits: state.digits,
        lastRequestedCodeAt: state.lastRequestedCodeAt,
      ));
      Timer(const Duration(seconds: 1), () {
        emit(PhoneVerificationSuccessState(
            lastRequestedCodeAt: state.lastRequestedCodeAt));
      });
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
