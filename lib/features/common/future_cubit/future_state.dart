part of 'future_cubit.dart';

sealed class FutureState<T> extends Equatable {
  final bool isLoading;
  final T? data;

  const FutureState({required this.isLoading, this.data});

  const factory FutureState.initial() = InitialFutureState;
  const factory FutureState.busy([T? data]) = BusyFutureState;
  const factory FutureState.error(
    AppException appException, {
    T? data,
  }) = ErrorFutureState;
  const factory FutureState.data(T data) = DataFutureState;

  @override
  List<Object?> get props => [isLoading, data];
}

final class InitialFutureState<T> extends FutureState<T> {
  const InitialFutureState() : super(isLoading: false);
}

final class BusyFutureState<T> extends FutureState<T> {
  const BusyFutureState([T? data]) : super(isLoading: true, data: data);
}

final class DataFutureState<T> extends FutureState<T> {
  const DataFutureState(T data) : super(isLoading: false, data: data);
}

final class ErrorFutureState<T> extends FutureState<T> {
  const ErrorFutureState(this.appException, {super.data})
      : super(isLoading: false);
  final AppException appException;
  @override
  List<Object?> get props => [...super.props, appException];
}
