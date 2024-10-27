import 'package:healing_guide_flutter/features/user/models.dart';

class SignupRequest {
  /// A location\Route to navigate to when signup is completed successfully
  final String redirectTo;

  /// The role to register with
  final Role signupAs;
  const SignupRequest({required this.redirectTo, required this.signupAs});
}
