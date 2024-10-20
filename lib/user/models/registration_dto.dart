import 'package:healing_guide_flutter/user/models/role.dart';

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
