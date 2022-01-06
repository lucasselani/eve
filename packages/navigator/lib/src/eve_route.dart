import 'package:flutter/material.dart';

class EveRoute {
  final Widget Function(dynamic args) createWidget;
  final String routeName;

  EveRoute({required this.createWidget, required this.routeName});
}
