import 'package:equatable/equatable.dart';
import 'package:healing_guide_flutter/user/models.dart';

@Equatable()
final class AuthState {
  const AuthState._({this.user});
  final User? user;

  factory AuthState.authenticated(User user) {
    return AuthState._(user: user);
  }
  factory AuthState.unauthenticated() {
    return const AuthState._();
  }
  @override
  String toString() {
    return user != null
        ? 'AuthState.authenticated'
        : 'AuthState.unauthenticated';
  }
}
