import 'package:navigator/src/eve_route.dart';

abstract class EveNavigationModule {
  List<EveRoute> get routes;
  bool guard();
}
