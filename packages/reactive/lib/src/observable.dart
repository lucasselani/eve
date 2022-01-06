import 'package:abstractions/src/functional/data_state.dart';
import 'package:flutter/material.dart';

class Observable<T> extends ValueNotifier<DataState<T>> {
  Observable({DataState<T> value = const EmptyState()}) : super(value);
}
