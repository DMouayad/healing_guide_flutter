import 'package:equatable/equatable.dart';

import 'role.dart';

class User extends Equatable {
  final int id;
  final Role role;
  final bool activated;
  final String email;
  final String phoneNumber;
  final String fullName;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneNumberVerifiedAt;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.role,
    required this.activated,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.emailVerifiedAt,
    required this.phoneNumberVerifiedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        role,
        activated,
        email,
        phoneNumber,
        fullName,
        emailVerifiedAt,
        phoneNumberVerifiedAt,
        createdAt
      ];
}
