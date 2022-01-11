import 'package:eve/eve.dart';
import 'package:example/base_app/base_app_i18n_module.dart';
import 'package:example/base_app/base_app_navigation_module.dart';
import 'package:example/micro_app_counter/micro_app_counter.dart';

class BaseAppImpl extends BaseApp {
  EveI18nModule get i18nModule => BaseAppI18nModule(packageName);

  @override
  get navigatorModule => BaseAppNavigationModule();

  @override
  List<CommonPackage> get packages => [MicroAppCounter()];
}
