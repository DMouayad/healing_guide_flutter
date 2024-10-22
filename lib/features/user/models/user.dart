import 'package:equatable/equatable.dart';

import 'role.dart';

@Equatable()
class User {
  final int id;
  final Role role;
  final bool activated;
  final String email;
  final String phoneNumber;
  final String fullName;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneNumberVerifiedAt;
  final DateTime createdAt;

  User({
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
}
