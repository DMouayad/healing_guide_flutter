part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  final bool isBusy;
  const UserProfileState({required this.isBusy});

  @override
  List<Object?> get props => [isBusy];
}

final class UserProfileInitial extends UserProfileState {
  const UserProfileInitial() : super(isBusy: false);
}

class UserProfileInProgressState extends UserProfileState {
  const UserProfileInProgressState() : super(isBusy: true);
}

class LogoutInProgressState extends UserProfileInProgressState {
  const LogoutInProgressState() : super();
}

class UserProfileFailureState extends UserProfileState {
  final AppException appException;
  const UserProfileFailureState(this.appException) : super(isBusy: false);
  @override
  List<Object?> get props => [appException, ...super.props];
}

class LogoutFailureState extends UserProfileFailureState {
  const LogoutFailureState(super.appException);
}
