part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState({required this.isBusy});
  final bool isBusy;
}

final class LoginIdleState extends LoginState {
  LoginIdleState() : super(isBusy: false);
}

final class LoginBusyState extends LoginState {
  LoginBusyState() : super(isBusy: true);
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState() : super(isBusy: false);
}

final class LoginFailureState extends LoginState {
  final AppException appException;
  const LoginFailureState(this.appException) : super(isBusy: false);
}
