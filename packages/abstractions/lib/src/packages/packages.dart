import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

abstract class CommonPackage {
  Future<void> initialize() async {}
  Future<void> dispose() async {}
}

abstract class MicroApp extends CommonPackage {
  String get packageName;
  EveI18nModule get i18nModule;
  EveNavigationModule get navigatorModule;
}

abstract class BaseApp extends MicroApp {
  List<CommonPackage> get packages;
  Locale get defaultLanguage;
  List<Locale> get supportedLanguages;
  EveTheme get defaultTheme;
  EveTheme? get darkTheme => null;

  @override
  String get packageName => 'baseApp';
}
