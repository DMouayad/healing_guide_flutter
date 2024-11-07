import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_guide_flutter/features/home/home_screen.dart';
import 'package:healing_guide_flutter/features/login/login_screen.dart';
import 'package:healing_guide_flutter/features/phone_verification/phone_verification_screen.dart';
import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/search/search_screen.dart';
import 'package:healing_guide_flutter/features/signup/cubit/signup_cubit.dart';
import 'package:healing_guide_flutter/features/signup/signup_screen.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/features/user_profile/user_profile_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(path: '/')
@immutable
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute();
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
  final Role role;
  const SignupScreenRoute({required this.role});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignupScreen(signupAs: role);
  }
}

@TypedGoRoute<PhoneVerificationScreenRoute>(path: '/phone-verification')
@immutable
class PhoneVerificationScreenRoute extends GoRouteData {
  const PhoneVerificationScreenRoute(this.$extra);
  final SignupCubit $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PhoneVerificationScreen(signupCubit: $extra);
  }
}

@TypedGoRoute<UserProfileScreenRoute>(path: '/user-profile')
@immutable
class UserProfileScreenRoute extends GoRouteData {
  const UserProfileScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserProfileScreen();
  }
}

@TypedGoRoute<SearchScreenRoute>(path: '/search')
@immutable
class SearchScreenRoute extends GoRouteData {
  const SearchScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SearchScreen();
  }
}
