part of '../repositories.dart';

final class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository(super.userRepository);

  @override
  Future<void> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
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
  void logOut() {
    _controller.add(AuthState.unauthenticated());
  }

  @override
  Future<void> register(UserRegistrationDTO dto) async {
    final user = userFromDTO(dto);
    await _userRepository.saveUser(user);
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => _controller.add(AuthState.authenticated(user)),
    );
  }

  User userFromDTO(UserRegistrationDTO dto) {
    return const UserBuilder().build(
      email: dto.email,
      phoneNumber: dto.phoneNumber,
      fullName: dto.fullName,
      role: dto.role,
    );
  }
}
