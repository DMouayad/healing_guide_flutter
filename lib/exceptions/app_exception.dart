import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

enum AppException {
  /// A custom exception in the application domain.
  ///
  /// - Call `getMessage(context)` to get the translated message of a thrown exception.
  // Connection & Internet
  noInternetConnectionFound,
  locationServiceDisabled,
  locationPermissionDenied,
  locationPermissionDeniedPermanently,
  cannotConnectToServer,
  // Authorization
  unauthorized,
  // Authentication
  unauthenticated,
  accountAlreadyExist,
  invalidLoginCredential,
  // API & HTTP requests
  invalidApiRequest,
  apiServerError,
  // Misc
  notFound,
  decodingJsonFailed,

  /// Indicates that an unknown error has occurred or an un expected exception
  /// was thrown.
  ///
  /// - This applies for unregistered\unknown API exceptions,
  /// an exception from external packages, etc.
  /// - This error should be found in the logs to.
  undefined;

  const AppException();

  String getMessage(BuildContext context) {
    return switch (this) {
      AppException.noInternetConnectionFound =>
        context.l10n.noInternetConnection,
      AppException.cannotConnectToServer => context.l10n.cannotConnectToServer,
      AppException.unauthorized => context.l10n.unauthorized,
      AppException.unauthenticated => context.l10n.unauthenticated,
      AppException.accountAlreadyExist => context.l10n.accountAlreadyExist,
      AppException.invalidLoginCredential =>
        context.l10n.invalidLoginCredential,
      AppException.locationPermissionDenied =>
        context.l10n.locationPermissionDenied,
      AppException.locationPermissionDeniedPermanently =>
        context.l10n.locationPermissionDeniedPermanently,
      AppException.locationServiceDisabled =>
        context.l10n.locationServiceDisabled,
      AppException.invalidApiRequest ||
      AppException.apiServerError =>
        context.l10n.serverError,
      _ => context.l10n.undefinedException,
    };
  }

  factory AppException.fromHttpResponse(int statusCode) {
    return switch (statusCode) {
      HttpStatus.unauthorized => AppException.unauthenticated,
      HttpStatus.notFound => AppException.notFound,
      _ => AppException.apiServerError,
    };
  }
}
