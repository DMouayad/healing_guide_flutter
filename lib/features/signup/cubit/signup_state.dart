part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState({required this.isBusy});
  final bool isBusy;

  @override
  List<Object?> get props => [isBusy];

  Map<String, dynamic> toJson() {
    return {
      "isBusy": isBusy,
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

  const SignupPendingPhoneVerificationState(this.dto) : super(isBusy: false);
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
  const SignupPendingCompletionState(this.dto) : super(isBusy: false);
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
  final AppException appException;
  const SignupFailureState(this.appException) : super(isBusy: false);
  @override
  List<Object?> get props => [appException, ...super.props];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'appException': appException.index,
    };
  }
}
