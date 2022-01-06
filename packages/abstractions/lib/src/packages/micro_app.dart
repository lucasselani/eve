import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

abstract class MicroApp {
  Future<void> register();
  Future<void> dispose();
  String get packageName;
  late final EveNavigatorModule? navigatorModule;
  late final EveI18nModule? i18nModule;
}
