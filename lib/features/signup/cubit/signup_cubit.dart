import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/signup/signup_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models.dart';

import '../signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  late final AuthRepository _authRepository;
  late final SignupFormHelper formHelper;
  final SignupRequest request;

  SignupCubit({required this.request, required AuthRepository authRepository})
      : super(SignupIdleState()) {
    formHelper = SignupFormHelper();
    _authRepository = authRepository;
  }

  Future<void> onSignupRequested() async {
    if (!formHelper.validateInput()) {
      return;
    }
    emit(SignupBusyState());
    try {
      await _authRepository.register(UserRegistrationDTO(
        password: formHelper.passwordValue,
        phoneNumber: formHelper.phoneNoValue,
        role: request.signupAs,
        email: formHelper.emailValue,
        fullName: formHelper.fullNameValue,
      ));
      emit(SignupSuccessState());
    } catch (e) {
      AppException appException =
          e is AppException ? e : AppException.undefined;
      emit(SignupFailureState(appException));
    } finally {
      if (state.isBusy) {
        emit(SignupIdleState());
      }
    }
  }
}
