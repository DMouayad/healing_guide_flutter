import 'dart:async';

import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

FutureOr<T?> errorHandler<T>(
  FutureOr<T> Function() func,
  void Function(AppException exception) onError, {
  bool logError = true,
}) async {
  try {
    return await func();
  } catch (e) {
    final exception = switch (e) {
      AppException appException => appException,
      _ => AppException.undefined,
    };
    if (logError) {
      pLogger.e(e);
    }
    onError(exception);
  }
  return null;
}
