part of '../repositories.dart';

abstract base class AuthRepository {
  late final UserRepository _userRepository;
  AuthRepository(UserRepository userRepository) {
    _userRepository = userRepository;
  }

  final _controller = StreamController<AuthState>();
  Stream<AuthState> get status => _controller.stream;

  Future<void> loadPrevUser() async {
    return _userRepository.getUser().then((user) => switch (user) {
          User() => _controller.add(AuthState.authenticated(user)),
          null => _controller.add(AuthState.unauthenticated()),
        });
  }

  Future<void> logIn({
    required String phoneNumber,
    required String password,
  });

  Future<void> register(UserRegistrationDTO dto);

  void logOut();

  void dispose() => _controller.close();
}
