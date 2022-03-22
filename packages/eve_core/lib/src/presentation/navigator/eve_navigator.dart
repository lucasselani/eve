import 'package:eve_core/src/data/drivers/injector.dart';
import 'package:eve_core/src/presentation/navigator/eve_navigator_observer.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

enum NavMode {
  push,
  clearAndPush,
  replace,
}

class EveNavigator {
  final GlobalKey<NavigatorState> _key;
  final EveNavigatorObserver _observer;

  EveNavigator._(this._key, this._observer);

  factory EveNavigator() {
    if (!Injector().isRegistered<EveNavigator>()) {
      throw Exception('navigator is not registered');
    }
    return Injector().get<EveNavigator>();
  }

  static void create({
    required GlobalKey<NavigatorState> key,
    required EveNavigatorObserver observer,
    String name = 'default',
  }) {
    Injector().registerSingleton<EveNavigator>(EveNavigator._(key, observer));
  }

  /// Get the current navigator context
  BuildContext? get context => _key.currentContext;

  /// Get the current route name
  String? get currentRoute => _observer.history.isNotEmpty
      ? _observer.history.last.settings.name
      : null;

  /// Get the current route name
  List<String> get routes => _observer.history
      .where((route) => route.settings.name != null)
      .map((route) => route.settings.name!)
      .toList();

  /// Get the number of routes between the given route and the current route
  int? distanceFromCurrentRoute(String routeName) =>
      _observer.fromTopUntil(routeName);

  /// Navigate to next route
  /// [mode] navigation mode: push, clear all before push or replace current route
  /// [name] name of the route you want to go
  /// [widget] the widget you want to go
  /// Note 1: priority of selection = widget > name
  /// Note 2: if you pass both the name and the widget, Admiral will navigate to the [widget]
  /// and will use the [name] as the navigation settings.
  Future<dynamic> go({
    required NavMode mode,
    String? name,
    Widget? widget,
    dynamic args,
  }) {
    final control = _NavControl.to(
      name: name,
      widget: widget,
      args: args,
      key: _key,
    );
    switch (mode) {
      case NavMode.push:
        return control.push();
      case NavMode.clearAndPush:
        return control.clearAndPush();
      case NavMode.replace:
        return control.replace();
    }
  }

  /// Pop current route
  /// [data] to be returned to the previous route
  /// [times] number of pops you want to do
  /// [toRoute] name of the route you want to pop to (it will override the [times] value if the route is found)
  void pop({
    dynamic data,
    int times = 1,
    String? toRoute,
  }) {
    if (toRoute != null) {
      times = _observer.fromTopUntil(toRoute) ?? times;
    }
    try {
      for (var i = 0; i < times; i++) {
        _NavControl(key: _key).navState?.pop(data);
      }
    } catch (_) {}
  }

  /// Refresh current page the current navigation and history by navigating to the default route: '/'
  void restart() {
    final control = _NavControl.to(
      name: '/',
      key: _key,
    );
    control.clearAndPush();
  }
}

class _NavControl {
  final NavigatorState? navState;
  final String? name;
  final Route? to;
  final dynamic args;

  /// Create a default navigator
  _NavControl({
    this.name,
    this.to,
    this.args,
    required GlobalKey<NavigatorState> key,
  }) : navState = Navigator.of(key.currentContext!);

  /// Create a navigator to go to next routes
  factory _NavControl.to({
    Widget? widget,
    String? name,
    dynamic args,
    required GlobalKey<NavigatorState> key,
  }) {
    final to = widget != null
        ? MaterialPageRoute(
            builder: (_) => widget,
            settings: RouteSettings(name: name),
          )
        : null;
    return _NavControl(name: name, to: to, args: args, key: key);
  }

  /// Replace current route
  Future<dynamic> replace() => _navigate(
        () async {
          if (to != null) {
            return await navState?.pushReplacement(to!);
          }
          if (name != null) {
            return await navState?.pushReplacementNamed(name!, arguments: args);
          }
        },
      );

  /// Push new route
  Future<dynamic> push() => _navigate(() async {
        if (to != null) {
          return await navState?.push(to!);
        }
        if (name != null) {
          return await navState?.pushNamed(name!, arguments: args);
        }
      });

  /// Clear all routes but new one
  // ignore: use_function_type_syntax_for_parameters
  Future<dynamic> clearAndPush({bool Function(Route<dynamic>)? predicate}) =>
      _navigate(() async {
        if (to != null) {
          return await navState?.pushAndRemoveUntil(
            to!,
            predicate ?? _clearPredicate,
          );
        }
        if (name != null) {
          return await navState?.pushNamedAndRemoveUntil(
            name!,
            predicate ?? _clearPredicate,
            arguments: args,
          );
        }
      });

  bool _clearPredicate(Route<dynamic> route) => false;

  Future<dynamic> _navigate(Future<dynamic> Function() navigation) async {
    try {
      return await navigation();
    } catch (e, stacktrace) {
      log('failed to navigate', error: e, stackTrace: stacktrace);
      return null;
    }
  }
}
