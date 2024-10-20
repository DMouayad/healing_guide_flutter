part of '../repositories.dart';

final class ApiAuthRepository extends AuthRepository {
  ApiAuthRepository(super.userRepository);

  @override
  Future<void> logIn({
    required String phoneNumber,
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
  Future<void> register(UserRegistrationDTO dto) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
