import 'package:eve_core/eve_core.dart';
import 'package:example/micro_app_counter/presentation/counter_view.dart';

class CounterNavigatorModule implements EveNavigationModule {
  @override
  bool guard() => true;

  @override
  List<EveRoute> get routes => [
        EveRoute(
            createWidget: (args) => const CounterView(), routeName: '/counter')
      ];

  @override
  String get entryPoint => '/counter';
}
