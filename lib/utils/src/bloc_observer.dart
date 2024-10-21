part of '../utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    sLogger.i('${bloc.runtimeType}($change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    sLogger.i('${bloc.runtimeType}($error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
