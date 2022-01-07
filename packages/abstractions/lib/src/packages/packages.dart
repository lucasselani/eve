import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

abstract class CommonPackage {
  Future<void> initialize() async {}
  Future<void> dispose() async {}
}

abstract class MicroApp extends CommonPackage {
  String get packageName;
  I18nModule? get i18nModule => null;
  NavigatorModule? get navigatorModule => null;
}

abstract class BaseApp extends CommonPackage {
  List<CommonPackage> get packages => [];
  I18nModule get i18nModule;
  NavigatorModule get navigatorModule;
}
