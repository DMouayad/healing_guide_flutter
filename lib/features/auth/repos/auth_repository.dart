part of '../repositories.dart';

abstract base class AuthRepository {
  late final UserRepository _userRepository;
  AuthRepository(UserRepository userRepository) {
    _userRepository = userRepository;
  }

  final _controller = StreamController<AuthState>.broadcast();
  Stream<AuthState> get status => _controller.stream;

  Future<void> loadPrevUser() async {
    return _userRepository.getUser().then((user) => switch (user) {
          User() => _controller.add(AuthState.authenticated(user)),
          null => _controller.add(AuthState.unauthenticated()),
        });
  }

  Future<void> logIn(UserLoginDTO dto);

  Future<void> startRegistration(StartRegistrationDTO dto);
  Future<void> completePatientRegistration(CompletePatientRegistrationDTO dto);
  Future<void> completePhysicianRegistration(
    CompletePhysicianRegistrationDTO dto,
  );

  Future<void> logOut();

  void dispose() => _controller.close();
}
