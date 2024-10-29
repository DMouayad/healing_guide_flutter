part of 'signup_cubit.dart';

sealed class SignupState {
  const SignupState({required this.isBusy, this.dto});
  final bool isBusy;
  final UserRegistrationDTO? dto;
}

final class SignupIdleState extends SignupState {
  SignupIdleState() : super(isBusy: false);
}

final class SignupBusyState extends SignupState {
  SignupBusyState() : super(isBusy: true);
}

final class SignupPendingPhoneVerificationState extends SignupState {
  SignupPendingPhoneVerificationState({required UserRegistrationDTO dto})
      : super(isBusy: false, dto: dto);

  @override
  UserRegistrationDTO get dto => super.dto!;
}

final class SignupSuccessState extends SignupState {
  SignupSuccessState() : super(isBusy: false);
}

final class SignupFailureState extends SignupState {
  final AppException appException;
  const SignupFailureState(this.appException) : super(isBusy: false);
}
