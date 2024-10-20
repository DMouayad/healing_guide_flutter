part of '../repositories.dart';

final class FakeAuthRepository extends AuthRepository {
  @override
  Future<void> logIn({
    required String emailOrPhoneNo,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  @override
  void logOut() {
    _controller.add(AuthStatus.authenticated);
  }

  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> register(UserRegistrationDTO dto) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => _controller.add(AuthStatus.authenticated),
    );
  }
}
