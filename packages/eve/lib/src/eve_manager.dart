import 'dart:async';

import 'package:eve/eve.dart';
import 'package:flutter/material.dart';

class EveManager with ChangeNotifier {
  static Map<String, EveManager> _instances = {};

  final BaseApp app;
  final EveTheme defaultTheme;
  final EveTheme? darkTheme;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode && darkTheme != null;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  Completer<void> _initialization = Completer();
  Future get initialization => _initialization.future;
  bool get isInitialized => _initialization.isCompleted;

  EveManager._(
    this.app,
    this.defaultTheme,
    this.darkTheme,
  );

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
    required EveTheme defaultTheme,
    EveTheme? darkTheme,
  }) {
    if (_instances[name] == null) {
      _instances[name] = EveManager._(app, defaultTheme, darkTheme);
      _instances[name]!._initialize();
    }
    return _instances[name]!;
  }

  Future<void> _initialize() async {
    if (isInitialized) return;
    await app.initialize();
    for (final package in app.packages) {
      await package.initialize();
    }
    _initialization.complete();
  }

  @override
  void dispose() {
    app.dispose();
    for (final package in app.packages) {
      package.dispose();
    }
    _initialization = Completer();
    super.dispose();
  }
}
