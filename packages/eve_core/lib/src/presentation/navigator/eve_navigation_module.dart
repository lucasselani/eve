import 'package:flutter/material.dart';

class EveRoute {
  final Widget Function(dynamic args) createWidget;
  final String routeName;

  EveRoute({required this.createWidget, required this.routeName});
}

abstract class EveNavigationModule {
  /// A List of [EveRoute] to be registered in the MaterialApp
  List<EveRoute> get routes;

  /// A function that will not allow a route to be used if it returns [false]
  bool guard();

  /// The name of the initial route of the module
  String get entryPoint;
}
