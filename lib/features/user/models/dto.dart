import 'package:healing_guide_flutter/features/user/models/role.dart';

class UserRegistrationDTO {
  final Role role;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String password;

  UserRegistrationDTO({
    required this.role,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.password,
  });
}

class UserLoginDTO {
  final String phoneNumber;
  final String password;
  const UserLoginDTO({required this.phoneNumber, required this.password});
}

class UpdateUserDTO {
  final String? email;
  final String? phoneNumber;
  final String? fullName;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneNumberVerifiedAt;

  UpdateUserDTO({
    this.email,
    this.phoneNumber,
    this.fullName,
    this.emailVerifiedAt,
    this.phoneNumberVerifiedAt,
  });
}
