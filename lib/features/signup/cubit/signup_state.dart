part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState({required this.isBusy, this.appException});
  final bool isBusy;
  final AppException? appException;

  bool get hasException => appException != null;

  @override
  List<Object?> get props => [isBusy, appException];

  Map<String, dynamic> toJson() {
    return {
      "isBusy": isBusy,
      "appException": appException?.index,
    };
  }

  SignupState copyWithBusy({required bool isBusy}) {
    return switch (this) {
      SignupIdleState() => isBusy ? const SignupBusyState() : this,
      SignupBusyState() => isBusy ? this : const SignupIdleState(),
      SignupPendingPhoneVerificationState s =>
        SignupPendingPhoneVerificationState(s.dto, isBusy: isBusy),
      SignupPendingCompletionState s =>
        SignupPendingCompletionState(s.dto, isBusy: isBusy),
      SignupSuccessState() => this,
      SignupFailureState() => isBusy ? const SignupBusyState() : this,
    };
  }

  SignupState copyWithException(AppException exception) {
    return switch (this) {
      SignupPendingPhoneVerificationState s =>
        SignupPendingPhoneVerificationState(s.dto,
            appException: exception, isBusy: false),
      SignupPendingCompletionState s => SignupPendingCompletionState(s.dto,
          isBusy: false, appException: exception),
      _ => SignupFailureState(exception),
    };
  }
}

final class SignupIdleState extends SignupState {
  const SignupIdleState() : super(isBusy: false);
}

final class SignupBusyState extends SignupState {
  const SignupBusyState() : super(isBusy: true);
}

final class SignupPendingPhoneVerificationState extends SignupState {
  static const stepName = 'PendingPhoneVerification';

  final StartRegistrationDTO dto;

  const SignupPendingPhoneVerificationState(
    this.dto, {
    super.isBusy = false,
    super.appException,
  });
  @override
  List<Object?> get props => [...super.props, dto];

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'dto': dto.toJson(), 'step': stepName};
  }
}

final class SignupPendingCompletionState extends SignupState {
  static const stepName = 'PendingInfoCompletion';
  final StartRegistrationDTO dto;
  const SignupPendingCompletionState(
    this.dto, {
    super.isBusy = false,
    super.appException,
  });

  @override
  List<Object?> get props => [...super.props, dto];

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'dto': dto.toJson(), 'step': stepName};
  }
}

final class SignupSuccessState extends SignupState {
  const SignupSuccessState() : super(isBusy: false);
}

final class SignupFailureState extends SignupState {
  const SignupFailureState(AppException appException)
      : super(isBusy: false, appException: appException);
}
