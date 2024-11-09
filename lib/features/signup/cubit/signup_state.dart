part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState({required this.isBusy});
  final bool isBusy;

  @override
  List<Object?> get props => [isBusy];
}

final class SignupIdleState extends SignupState {
  const SignupIdleState() : super(isBusy: false);
}

final class SignupBusyState extends SignupState {
  const SignupBusyState() : super(isBusy: true);
}

final class SignupPendingPhoneVerificationState extends SignupState {
  final String email;
  final String phoneNumber;
  final String password;

  const SignupPendingPhoneVerificationState({
    required this.email,
    required this.phoneNumber,
    required this.password,
  }) : super(isBusy: false);
  @override
  List<Object?> get props => [...super.props, email, phoneNumber, password];
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
