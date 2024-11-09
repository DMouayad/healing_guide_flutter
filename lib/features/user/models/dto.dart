import 'package:healing_guide_flutter/features/user/models/role.dart';

class CompleteRegistrationDTO {
  final Role role;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String password;

  const CompleteRegistrationDTO({
    required this.role,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.password,
  });
}

class StartRegistrationDTO {
  final Role role;
  final String email;
  final String phoneNumber;
  final String password;

  const StartRegistrationDTO({
    required this.role,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}

class UserLoginDTO {
  final String email;
  final String password;
  const UserLoginDTO({required this.email, required this.password});
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
