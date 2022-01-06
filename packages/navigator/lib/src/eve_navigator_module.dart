import 'package:navigator/src/eve_route.dart';

abstract class EveNavigatorModule {
  List<EveRoute> get routes;
  bool guard();
}
