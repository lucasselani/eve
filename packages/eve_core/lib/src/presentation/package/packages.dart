import 'dart:async';

import 'package:eve_core/src/presentation/i18n/eve_i18n_module.dart';
import 'package:eve_core/src/presentation/navigator/eve_navigation_module.dart';
import 'package:flutter/material.dart';

abstract class CommonPackage {
  FutureOr<void> initialize() async {}
  FutureOr<void> dispose() async {}
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
  ThemeData get defaultTheme;
  ThemeData? get darkTheme => null;

  @override
  String get packageName => 'baseApp';
}
