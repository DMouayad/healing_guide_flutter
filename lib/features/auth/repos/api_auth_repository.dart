part of '../repositories.dart';

final class ApiAuthRepository extends AuthRepository {
  ApiAuthRepository(super.userRepository);

  @override
  Future<void> logIn(UserLoginDTO dto) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
  }

  @override
  Future<void> register(UserRegistrationDTO dto) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
