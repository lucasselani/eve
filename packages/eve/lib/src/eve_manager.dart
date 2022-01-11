import 'dart:async';

import 'package:eve/eve.dart';
import 'package:eve/src/data/repositories/eve_repository.dart';
import 'package:eve/src/domain/repositories/eve_repository.dart';
import 'package:eve/src/domain/use_cases/eve_manager_use_cases.dart';
import 'package:flutter/material.dart';

class EveManager with ChangeNotifier {
  static Map<String, EveManager> _instances = {};

  final BaseApp app;

  late bool _isDarkMode;
  bool get isDarkMode => _isDarkMode && app.darkTheme != null;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    UseCaseSetIsDarkTheme(_isDarkMode).run();
    notifyListeners();
  }

  late Locale _currentLanguage;
  Locale get currentLanguage => _currentLanguage;
  set currentLanguage(Locale locale) {
    _currentLanguage = locale;
    UseCaseSetCurrentLanguage(_currentLanguage).run();
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

  factory EveManager([String? name = 'default']) {
    final instance = _instances[name];
    if (instance == null) {
      throw Exception('You need a EveApp to work with EveManager!');
    }
    return _instances[name]!;
  }

  factory EveManager.initialize({
    required BaseApp app,
    required String name,
  }) {
    if (_instances[name] == null) {
      _instances[name] = EveManager._(app);
      _instances[name]!._initialize();
    }
    return _instances[name]!;
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
    final vault = await Vault.open(storageId: 'eveAppManager');
    Injector('eveApp')
        .map<EveRepository>(() => EveRepositoryImpl(vault), isSingleton: true);
    _isDarkMode = UseCaseIsDarkTheme().run();
    _currentLanguage = UseCaseGetCurrentLanguage(app.defaultLanguage).run();
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
