part of '../auth.dart';

final class ApiAuthRepository extends AuthRepository {
  @override
  Future<void> logIn({
    required String emailOrPhoneNo,
    required String password,
  }) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  void logOut() {
    // TODO: implement logOut
  }

  @override
  // TODO: implement status
  Stream<AuthStatus> get status => throw UnimplementedError();

  @override
  Future<void> register(UserRegistrationDTO dto) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
