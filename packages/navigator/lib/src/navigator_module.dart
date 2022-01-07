import 'package:navigator/src/eve_route.dart';

abstract class NavigatorModule {
  List<EveRoute> get routes;
  bool guard();
}
