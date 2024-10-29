// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeScreenRoute,
      $loginScreenRoute,
      $signupScreenRoute,
      $phoneVerificationScreenRoute,
    ];

RouteBase get $homeScreenRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeScreenRouteExtension._fromState,
    );

extension $HomeScreenRouteExtension on HomeScreenRoute {
  static HomeScreenRoute _fromState(GoRouterState state) => HomeScreenRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginScreenRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginScreenRouteExtension._fromState,
    );

extension $LoginScreenRouteExtension on LoginScreenRoute {
  static LoginScreenRoute _fromState(GoRouterState state) => LoginScreenRoute(
        redirectTo: state.uri.queryParameters['redirect-to']!,
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          'redirect-to': redirectTo,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupScreenRoute => GoRouteData.$route(
      path: '/signup/:role',
      factory: $SignupScreenRouteExtension._fromState,
    );

extension $SignupScreenRouteExtension on SignupScreenRoute {
  static SignupScreenRoute _fromState(GoRouterState state) => SignupScreenRoute(
        role: _$RoleEnumMap._$fromName(state.pathParameters['role']!),
      );

  String get location => GoRouteData.$location(
        '/signup/${Uri.encodeComponent(_$RoleEnumMap[role]!)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$RoleEnumMap = {
  Role.patient: 'patient',
  Role.physician: 'physician',
  Role.guest: 'guest',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $phoneVerificationScreenRoute => GoRouteData.$route(
      path: '/phone-verification',
      factory: $PhoneVerificationScreenRouteExtension._fromState,
    );

extension $PhoneVerificationScreenRouteExtension
    on PhoneVerificationScreenRoute {
  static PhoneVerificationScreenRoute _fromState(GoRouterState state) =>
      PhoneVerificationScreenRoute(
        state.extra as SignupCubit,
      );

  String get location => GoRouteData.$location(
        '/phone-verification',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
