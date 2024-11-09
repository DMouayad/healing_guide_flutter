import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';

part 'future_state.dart';

class FutureCubit<T> extends Cubit<FutureState<T>> {
  FutureCubit([FutureState<T>? initialState])
      : super(initialState ?? const FutureState.initial());

  Future<void> runFuture(Future<T> Function() future) async {
    emit(FutureState.busy(state.data));

    try {
      final data = await future();
      emit(FutureState.data(data));
    } catch (e) {
      emit(FutureState.error(
        e is AppException ? e : AppException.undefined,
        data: state.data,
      ));
    }
  }
}
