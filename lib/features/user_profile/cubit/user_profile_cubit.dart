import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/utils/src/error_handler.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._authRepository) : super(const UserProfileInitial());
  final AuthRepository _authRepository;

  Future<void> onLogoutRequested() async {
    if (!state.isBusy) {
      emit(const LogoutInProgressState());
      await errorHandler(() => _authRepository.logOut(), (exception) {
        emit(LogoutFailureState(exception));
      });
    }
  }

  void onDeleteAccountRequested() {}

  void onChangePasswordRequested() {}
}
