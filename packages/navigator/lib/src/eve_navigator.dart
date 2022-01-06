import 'package:flutter/material.dart';
import 'package:navigator/src/admiral.dart';
import 'package:navigator/src/eve_navigator_module.dart';
import 'package:navigator/src/eve_navigator_observer.dart';

class EveNavigator {
  final String name;
  final List<EveNavigatorModule> navigatorModules;

  EveNavigator({
    required this.navigatorModules,
    this.name = 'default',
  }) {
    Admiral.create(
      key: GlobalKey<NavigatorState>(),
      observer: EveNavigatorObserver(),
      name: name,
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) {
      return _invalidRoute();
    }

    final routeName = settings.name!;
    for (final module in navigatorModules) {
      final routes = module.routes.where(
        (route) => route.routeName == routeName,
      );
      if (routes.isEmpty) {
        continue;
      }

      if (!module.guard()) {
        return _invalidRoute();
      }

      return _createRoute(
        routes.first.createWidget(settings.arguments),
        args: settings.arguments,
        name: routeName,
      );
    }
    return _invalidRoute();
  }

  Route _invalidRoute() => _createRoute(
        const Center(
          child: Text('invalid route'),
        ),
      );

  Route _createRoute(
    Widget widget, {
    String? name,
    dynamic args,
  }) =>
      MaterialPageRoute(
        builder: (_) => widget,
        settings: RouteSettings(name: name, arguments: args),
      );
}
