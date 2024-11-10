import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';

part 'future_state.dart';

class FutureCubit<T> extends Cubit<FutureState<T>> {
  late final BlocHelpers _helpers;

  FutureCubit([FutureState<T>? initialState])
      : super(initialState ?? const FutureState.idle()) {
    _helpers = BlocHelpers(
      setBusyTrue: () => emit(FutureState.busy(state.data)),
      setBusyFalse: () => emit(FutureState.idle(state.data)),
      isBusy: () => state.isLoading,
      onError: (exception) =>
          emit(FutureState.error(exception, data: state.data)),
    );
  }

  void runFuture(Future<T> future) {
    _helpers.handleFuture(
      future,
      onSuccess: (data) => emit(FutureState.data(data)),
    );
  }
}
