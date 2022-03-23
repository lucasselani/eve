import 'package:eve_core/src/domain/entities/data_state.dart';
import 'package:eve_core/src/domain/entities/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ObserverWidget<T> extends ValueListenableBuilder<DataState<T>> {
  ObserverWidget({
    Widget? child,
    Key? key,
    required ValueListenable<DataState<T>> listenable,
    required Widget Function(T value, Widget? child) onSuccess,
    Widget Function(Failure? failure, Widget? child)? onError,
    Widget Function(Widget? child)? onLoading,
    Widget Function(Widget? child)? onEmpty,
  }) : super(
          child: child,
          key: key,
          builder: (_, value, child) {
            if (value.isSuccess) {
              return onSuccess(value.data!, child);
            }
            if (value.isError) {
              if (onError != null) {
                return onError(value.error, child);
              }
              return Container();
            }
            if (value.isLoading) {
              if (onLoading != null) {
                return onLoading(child);
              }
              return Container();
            }
            if (onEmpty != null) {
              return onEmpty(child);
            }
            return Container();
          },
          valueListenable: listenable,
        );
}
