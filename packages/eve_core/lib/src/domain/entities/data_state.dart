import 'package:eve_core/src/domain/entities/failure.dart';

abstract class DataState<T> {
  const DataState();

  bool get isLoading => this is LoadingState;

  bool get isError => this is ErrorState;

  bool get isSuccess => this is SuccessState;

  bool get isEmpty => this is EmptyState;

  Failure? get error {
    if (isError) {
      return (this as ErrorState)._value;
    } else {
      throw Exception('Illegal use. You should isError check before calling ');
    }
  }

  T? get data {
    if (isSuccess) {
      return (this as SuccessState)._value;
    } else if (isEmpty) {
      return null;
    } else {
      throw Exception('Illegal use. You should isError check before calling ');
    }
  }
}

class LoadingState<T> extends DataState<T> {
  const LoadingState();
}

class EmptyState<T> extends DataState<T> {
  const EmptyState();
}

class ErrorState<T> extends DataState<T> {
  final Failure? _value;

  const ErrorState({Failure? failure}) : _value = failure;
}

class SuccessState<T> extends DataState<T> {
  final T _value;

  const SuccessState({required T data}) : _value = data;
}
