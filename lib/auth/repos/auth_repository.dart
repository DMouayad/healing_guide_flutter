part of '../repositories.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

abstract base class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status;

  Future<void> logIn({
    required String emailOrPhoneNo,
    required String password,
  });
  Future<void> register(UserRegistrationDTO dto);

  void logOut();

  void dispose() => _controller.close();
}
