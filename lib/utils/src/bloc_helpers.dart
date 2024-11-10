import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class BlocHelpers {
  final void Function() setBusyTrue;
  final void Function() setBusyFalse;
  final bool Function() isBusy;
  final void Function(AppException exception) onError;
  final Duration timeoutDuration;

  const BlocHelpers({
    required this.onError,
    required this.setBusyTrue,
    required this.setBusyFalse,
    required this.isBusy,
    this.timeoutDuration = const Duration(seconds: 20),
  });

  void handleFuture<T>(
    Future<T> future, {
    required void Function(T value) onSuccess,
    void Function(AppException exception)? onError,
  }) {
    setBusyTrue();

    future.then(onSuccess).onError((err, stackTrace) {
      AppException appException =
          err is AppException ? err : AppException.undefined;
      pLogger.e('$runtimeType', error: err, stackTrace: stackTrace);
      onError != null ? onError(appException) : this.onError(appException);
    }).timeout(timeoutDuration, onTimeout: () {
      if (isBusy()) setBusyFalse();
    });
  }
}
