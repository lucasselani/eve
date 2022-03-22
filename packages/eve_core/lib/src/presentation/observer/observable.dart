import 'package:eve_core/src/domain/entities/data_state.dart';
import 'package:eve_core/src/domain/entities/failure.dart';
import 'package:flutter/material.dart';

class Observable<T> extends ValueNotifier<DataState<T>> {
  Observable({DataState<T>? value}) : super(value ?? EmptyState<T>());

  void toLoading() => value = LoadingState<T>();

  void toEmpty() => value = EmptyState<T>();

  void toSuccess(T data) => value = SuccessState<T>(data: data);

  void toError(Failure failure) => value = ErrorState<T>(failure: failure);
}
