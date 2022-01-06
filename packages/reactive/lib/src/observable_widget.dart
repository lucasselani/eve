import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive/reactive.dart';

class ObservableWidget<T> extends ValueListenableBuilder<DataState<T>> {
  const ObservableWidget({
    Key? key,
    required Widget Function(
            BuildContext context, DataState<T> value, Widget? child)
        builder,
    required ValueListenable<DataState<T>> listenable,
    Widget? child,
  }) : super(
          child: child,
          key: key,
          builder: builder,
          valueListenable: listenable,
        );
}
