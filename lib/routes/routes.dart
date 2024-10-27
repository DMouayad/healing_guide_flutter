import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_guide_flutter/features/home/home_screen.dart';
import 'package:healing_guide_flutter/features/login/login_screen.dart';
import 'package:healing_guide_flutter/features/signup/signup_request.dart';
import 'package:healing_guide_flutter/features/signup/signup_screen.dart';
import 'package:healing_guide_flutter/features/user/models.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(path: '/')
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<LoginScreenRoute>(path: '/login')
@immutable
class LoginScreenRoute extends GoRouteData {
  final String redirectTo;

  const LoginScreenRoute({required this.redirectTo});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen(redirectTo: redirectTo);
  }
}

@TypedGoRoute<SignupScreenRoute>(path: '/signup/:role')
@immutable
class SignupScreenRoute extends GoRouteData {
  final String redirectTo;
  final Role role;
  const SignupScreenRoute({required this.redirectTo, required this.role});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignupScreen(
      request: SignupRequest(redirectTo: redirectTo, signupAs: Role.patient),
    );
  }
}
