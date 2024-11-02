part of 'user_profile_cubit.dart';

@Equatable()
class UserProfileState {
  final bool isBusy;
  const UserProfileState({required this.isBusy});
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
}

class LogoutFailureState extends UserProfileFailureState {
  LogoutFailureState(super.appException);
}
