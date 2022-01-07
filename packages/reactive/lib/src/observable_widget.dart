import 'package:abstractions/abstractions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive/reactive.dart';

class ObservableWidget<T> extends ValueListenableBuilder<DataState<T>> {
  ObservableWidget({
    Widget? child,
    Key? key,
    required ValueListenable<DataState<T>> listenable,
    required Widget Function(T value, Widget? child) onSuccess,
    Widget Function(Failure failure, Widget? child)? onError,
    Widget Function(Widget? child)? onLoading,
    Widget Function(Widget? child)? onEmpty,
  }) : super(
          child: child,
          key: key,
          builder: (_, value, child) {
            if (value.isSuccess) return onSuccess(value.data!, child);
            if (value.isError) {
              return onError != null
                  ? onError(value.error!, child)
                  : Container();
            }
            if (value.isLoading) {
              return onLoading != null ? onLoading(child) : Container();
            }
            return onEmpty != null ? onEmpty(child) : Container();
          },
          valueListenable: listenable,
        );
}
