import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

enum AppException {
  /// A custom exception in the application domain.
  ///
  /// - Call `getMessage(context)` to get the translated message of a thrown exception.
  // Connection & Internet
  noInternetConnectionFound,
  cannotConnectToServer,
  // Authorization
  unauthorized,
  // Authentication
  unauthenticated,
  accountAlreadyExist,
  invalidLoginCredential,
  // API & HTTP requests
  invalidApiRequest,
  // Misc
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
      AppException.invalidApiRequest ||
      AppException.decodingJsonFailed =>
        context.l10n.serverError,
      AppException.undefined => context.l10n.undefinedException
    };
  }
}
