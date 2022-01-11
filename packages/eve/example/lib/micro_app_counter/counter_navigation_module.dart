import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/presentation/counter_view.dart';

class CounterNavigatorModule implements EveNavigationModule {
  @override
  bool guard() => true;

  @override
  List<EveRoute> get routes =>
      [EveRoute(createWidget: (args) => CounterView(), routeName: '/counter')];
}
