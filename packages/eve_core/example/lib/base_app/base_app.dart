import 'package:eve_core/eve_core.dart';
import 'package:eve_design_system/eve_design_system.dart';
import 'package:example/base_app/base_app_i18n_module.dart';
import 'package:example/base_app/base_app_navigation_module.dart';
import 'package:example/micro_app_counter/micro_app_counter.dart';
import 'package:flutter/material.dart';

class BaseAppImpl extends BaseApp {
  @override
  EveI18nModule get i18nModule => BaseAppI18nModule(packageName);

  @override
  get navigatorModule => BaseAppNavigationModule();

  @override
  List<CommonPackage> get packages => [MicroAppCounter()];

  @override
  Locale get defaultLanguage => const Locale('pt', 'BR');

  @override
  List<Locale> get supportedLanguages =>
      const [Locale('pt', 'BR'), Locale('en')];

  @override
  ThemeData get defaultTheme => EveTheme.light(
        backgroundColor: Colors.white,
        primaryColor: Colors.blue,
        contentColor: Colors.black,
      ).themeData;

  @override
  ThemeData? get darkTheme => EveTheme.dark(
        backgroundColor: Colors.black87,
        primaryColor: Colors.lightGreen,
        contentColor: Colors.white,
      ).themeData;
}
