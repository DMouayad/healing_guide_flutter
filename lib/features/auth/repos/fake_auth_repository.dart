part of '../repositories.dart';

final class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository(super.userRepository) {
    _controller.stream.listen((state) => debugPrint(state.user.toString()));
  }

  @override
  Future<void> logIn(UserLoginDTO dto) async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        final user = await _userRepository.getUser();
        return switch (user) {
          User() => _controller.add(AuthState.authenticated(user)),
          null => _controller.add(AuthState.unauthenticated()),
        };
      },
    );
  }

  @override
  Future<void> logOut() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      _userRepository.deleteUser();
      _controller.add(AuthState.unauthenticated());
    });
  }

  Future<void> _completeRegistration(BaseCompleteRegistrationDTO dto) async {
    final user = _userFromDTO(dto);
    await _userRepository.saveUser(user);
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () => _controller.add(AuthState.authenticated(user)),
    );
  }

  User _userFromDTO(BaseCompleteRegistrationDTO dto) {
    return const UserBuilder().build(
      email: dto.email,
      phoneNumber: dto.phoneNumber,
      fullName: dto.fullName,
      role: dto.role,
    );
  }

  @override
  Future<void> startRegistration(StartRegistrationDTO dto) {
    // TODO: implement startRegistration
    throw UnimplementedError();
  }

  @override
  Future<void> completePatientRegistration(CompletePatientRegistrationDTO dto) {
    // TODO: implement completePatientRegistration
    throw UnimplementedError();
  }

  @override
  Future<void> completePhysicianRegistration(
      CompletePhysicianRegistrationDTO dto) {
    // TODO: implement completePhysicianRegistration
    throw UnimplementedError();
  }
}
