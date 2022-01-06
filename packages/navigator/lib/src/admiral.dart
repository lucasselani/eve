import 'dart:io';

import 'package:flutter/material.dart';
import 'package:navigator/src/eve_navigator_observer.dart';

class Admiral {
  static final Map<String, Admiral> _instances = {};

  final GlobalKey<NavigatorState> _key;
  GlobalKey<NavigatorState> get key => _key;
  final EveNavigatorObserver _observer;
  EveNavigatorObserver get observer => _observer;

  Admiral._(this._key, this._observer);

  factory Admiral([String name = 'default']) {
    if (_instances.containsKey(name)) return _instances[name]!;
    throw Exception('$name navigator is not implemented');
  }

  static void create({
    required GlobalKey<NavigatorState> key,
    required EveNavigatorObserver observer,
    String name = 'default',
  }) {
    _instances[name] = Admiral._(key, observer);
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
  /// [name] name of the route you want to go (must be registered in the GenomaNavigator)
  /// [widget] the widget you want to go (doesn't need to be registed in the GenomaNavigator)
  /// Note 1: priority of selection = widget > name
  /// Note 2: if you pass both the name and the widget, Admiral will navigate to the [widget]
  /// and will use the [name] as the navigation settings.
  NavControl to({
    String? name,
    Widget? widget,
    dynamic args,
  }) =>
      NavControl.to(
        name: name,
        widget: widget,
        args: args,
        key: _key,
      );

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
        NavControl(key: _key).navState?.pop(data);
      }
    } catch (_) {}
  }
}

class NavControl {
  final NavigatorState? navState;
  final String? name;
  final Route? to;
  final dynamic args;

  /// Create a default navigator
  NavControl({
    this.name,
    this.to,
    this.args,
    required GlobalKey<NavigatorState> key,
  }) : navState = Platform.environment.containsKey('FLUTTER_TEST') ||
                key.currentContext == null
            ? null
            : Navigator.of(key.currentContext!);

  /// Create a navigator to go to next routes
  factory NavControl.to({
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
    return NavControl(name: name, to: to, args: args, key: key);
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
    } catch (e) {
      return null;
    }
  }
}
