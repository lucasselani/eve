import 'package:eve_core/eve_core.dart';
import 'package:example/base_app/presentation/splash_view.dart';

class BaseAppNavigationModule implements EveNavigationModule {
  @override
  bool guard() => true;

  @override
  List<EveRoute> get routes => [
        EveRoute(createWidget: (args) => const SplashView(), routeName: '/'),
      ];

  @override
  String get entryPoint => '/';
}
