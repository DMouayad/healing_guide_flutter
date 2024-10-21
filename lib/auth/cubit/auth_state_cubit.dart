import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/auth/repositories.dart';

import '../models/auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthStateCubit(this._authRepository) : super(AuthState.unknown()) {
    _authRepository.status.listen(onAuthRepoStateChange);
  }

  void init() {
    _authRepository.loadPrevUser();
  }

  void onAuthRepoStateChange(AuthState state) => emit(state);
}