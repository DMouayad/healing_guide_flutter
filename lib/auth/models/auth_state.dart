import 'package:equatable/equatable.dart';
import 'package:healing_guide_flutter/user/models.dart';

@Equatable()
final class AuthState {
  const AuthState._({this.user});
  final User? user;

  factory AuthState.unknown() {
    return const AuthState._();
  }
  factory AuthState.authenticated(User user) {
    return AuthState._(user: user);
  }
  factory AuthState.unauthenticated() {
    return const AuthState._();
  }
}
