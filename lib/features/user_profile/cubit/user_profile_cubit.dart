import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  late final BlocHelpers _helpers;
  UserProfileCubit() : super(const UserProfileIdleState()) {
    _helpers = BlocHelpers(
      onError: (exception) => emit(UserProfileFailureState(exception)),
      setBusyTrue: () => emit(const UserProfileBusyState()),
      setBusyFalse: () => emit(const UserProfileIdleState()),
      isBusy: () => state.isBusy,
    );
  }

  AuthRepository get _authRepository => GetIt.I.get();

  Future<void> onLogoutRequested() async {
    if (state.isBusy) {
      return;
    }
    _helpers.handleFuture(
      _authRepository.logOut(),
      onSuccess: (value) {},
    );
  }

  void onDeleteAccountRequested() {}

  void onChangePasswordRequested() {}
}
