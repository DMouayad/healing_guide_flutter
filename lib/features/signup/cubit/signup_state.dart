part of 'signup_cubit.dart';

sealed class SignupState {
  const SignupState({required this.isBusy});
  final bool isBusy;
}

final class SignupIdleState extends SignupState {
  SignupIdleState() : super(isBusy: false);
}

final class SignupBusyState extends SignupState {
  SignupBusyState() : super(isBusy: true);
}

final class SignupSuccessState extends SignupState {
  SignupSuccessState() : super(isBusy: false);
}

final class SignupFailureState extends SignupState {
  final AppException appException;
  const SignupFailureState(this.appException) : super(isBusy: false);
}
