import 'package:flutter/material.dart';
import 'package:reactive/reactive.dart';

class Observable<T> extends ValueNotifier<DataState<T>> {
  Observable({DataState<T> value = const EmptyState()}) : super(value);
}
