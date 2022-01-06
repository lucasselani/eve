import 'package:flutter/material.dart';

class EveNavigatorObserver extends NavigatorObserver {
  final history = <Route>[];

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null && oldRoute != null) {
      final index = history.indexOf(oldRoute);
      history[index] = newRoute;
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    history.add(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    history.remove(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    history.remove(route);
  }

  int? fromTopUntil(String routeName) {
    final routes = history.where((route) => route.settings.name == routeName);
    if (routes.isEmpty) return null;

    return history.length - (history.indexOf(routes.first) + 1);
  }
}
