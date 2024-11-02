part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState({required this.isBusy, this.dto});
  final bool isBusy;
  final UserRegistrationDTO? dto;

  @override
  List<Object?> get props => [isBusy, dto];
}

final class SignupIdleState extends SignupState {
  const SignupIdleState() : super(isBusy: false);
}

final class SignupBusyState extends SignupState {
  const SignupBusyState() : super(isBusy: true);
}

final class SignupPendingPhoneVerificationState extends SignupState {
  const SignupPendingPhoneVerificationState({required UserRegistrationDTO dto})
      : super(isBusy: false, dto: dto);

  @override
  UserRegistrationDTO get dto => super.dto!;
}

final class SignupSuccessState extends SignupState {
  const SignupSuccessState() : super(isBusy: false);
}

final class SignupFailureState extends SignupState {
  final AppException appException;
  const SignupFailureState(this.appException) : super(isBusy: false);
  @override
  List<Object?> get props => [appException, ...super.props];
}
