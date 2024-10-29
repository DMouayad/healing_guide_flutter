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
  Map<String, String> toJson() {
    return {
      "role": role.name,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": "",
    };
  }

  static UserRegistrationDTO? fromJson(Map<String, dynamic>? json) {
    if (json
        case ({
          "role": String role,
          "email": String email,
          "phoneNumber": String phoneNumber,
          "fullName": String fullName,
          "password": String password,
        })) {
      return UserRegistrationDTO(
        role: Role.values.byName(role),
        email: email,
        phoneNumber: phoneNumber,
        fullName: fullName,
        password: password,
      );
    }
    return null;
  }
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
