import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

abstract class CommonPackage {
  Future<void> initialize() async {}
  Future<void> dispose() async {}
}

abstract class MicroApp extends CommonPackage {
  String get packageName;
  EveI18nModule? get i18nModule => null;
  EveNavigatorModule? get navigatorModule => null;
}

abstract class BaseApp extends CommonPackage {
  List<CommonPackage> get packages => [];
  EveI18nModule get i18nModule;
  EveNavigatorModule get navigatorModule;
  void onInitialized();
}
