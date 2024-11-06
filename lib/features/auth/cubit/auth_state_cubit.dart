import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';

import '../models/auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthRepository get _authRepository => GetIt.I.get();

  AuthStateCubit() : super(AuthState.unauthenticated()) {
    _authRepository.status.listen(_onAuthRepoStateChange);
  }

  void init() {
    _authRepository.loadPrevUser();
  }

  void _onAuthRepoStateChange(AuthState state) => emit(state);
}
