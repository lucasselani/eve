import 'dart:async';

import 'package:eve_core/src/data/datasources/vault.dart';
import 'package:eve_core/src/data/drivers/injector.dart';
import 'package:eve_core/src/data/repositories/eve_repository.dart';
import 'package:eve_core/src/domain/repositories/eve_repository.dart';
import 'package:eve_core/src/domain/use_cases/eve_manager_use_cases.dart';
import 'package:eve_core/src/presentation/navigator/eve_navigator.dart';
import 'package:eve_core/src/presentation/package/packages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EveManager with ChangeNotifier {
  final BaseApp app;

  late bool _isDarkMode;
  bool get isDarkMode => _isDarkMode && app.darkTheme != null;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    EveManagerUseCases().setDarkTheme(isDarkTheme: _isDarkMode);
    notifyListeners();
  }

  late Locale _currentLanguage;
  Locale get currentLanguage => _currentLanguage;
  set currentLanguage(Locale locale) {
    _currentLanguage = locale;
    EveManagerUseCases().setCurrentLanguage(currentLanguage: _currentLanguage);
    notifyListeners();
    EveNavigator().restart();
  }

  Completer<void> _appInitialization = Completer();
  Future get appInitialization => _appInitialization.future;
  bool get isAppInitialized => _appInitialization.isCompleted;

  Completer<void> _eveInitialization = Completer();
  Future get eveInitialization => _eveInitialization.future;
  bool get isEveInitialized => _eveInitialization.isCompleted;

  EveManager._(this.app);

  factory EveManager() {
    if (!Injector().isRegistered<EveManager>()) {
      throw Exception('You need an EveApp to work with EveManager!');
    }
    return Injector().get<EveManager>();
  }

  factory EveManager.initialize({
    required BaseApp app,
  }) {
    if (!Injector().isRegistered<EveManager>()) {
      final instance = EveManager._(app).._initialize();
      Injector().registerSingleton(instance);
    }
    return Injector().get<EveManager>();
  }

  Future<void> _initialize() async {
    if (isAppInitialized) return;
    await _initializeEve();
    await app.initialize();
    for (final package in app.packages) {
      await package.initialize();
    }
    _appInitialization.complete();
  }

  Future<void> _initializeEve() async {
    if (isEveInitialized) return;
    final sharedPref = await SharedPreferences.getInstance();
    Injector().registerSingleton<SharedPreferences>(sharedPref);

    final vault = Vault(storageId: 'eveManager');
    Injector().registerSingleton<EveRepository>(EveRepositoryImpl(vault));

    _isDarkMode = EveManagerUseCases().isDarkTheme();
    _currentLanguage = EveManagerUseCases()
        .getCurrentLanguage(defaultLanguage: app.defaultLanguage);
    _eveInitialization.complete();
  }

  @override
  void dispose() {
    app.dispose();
    for (final package in app.packages) {
      package.dispose();
    }
    _appInitialization = Completer();
    _eveInitialization = Completer();
    super.dispose();
  }
}
