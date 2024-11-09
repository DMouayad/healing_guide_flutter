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
  Future<void> completeRegistration(CompleteRegistrationDTO dto) async {
  }

  @override
  Future<void> startRegistration(StartRegistrationDTO dto) async {}
}
