import 'dart:async';

import 'package:eve/eve.dart';

class EveManager {
  static Map<String, EveManager> _instances = {};

  final BaseApp _app;

  Completer<void> _initialization = Completer();
  Future get initialization => _initialization.future;
  bool get isInitialized => _initialization.isCompleted;

  EveManager._(this._app);

  factory EveManager([String? name]) {
    final instance = _instances[name];
    if (instance == null) {
      throw Exception('You need a EveApp to work with EveManager!');
    }
    return _instances[name]!;
  }

  factory EveManager.initialize({required BaseApp app, required String name}) {
    if (_instances[name] == null) {
      _instances[name] = EveManager._(app);
      _instances[name]!._initialize();
    }
    return _instances[name]!;
  }

  Future<void> _initialize() async {
    if (isInitialized) return;
    await _app.initialize();
    for (final package in _app.packages) {
      await package.initialize();
    }
    _initialization.complete();
  }

  Future<void> dispose() async {
    await _app.dispose();
    for (final package in _app.packages) {
      await package.dispose();
    }
    _initialization = Completer();
  }
}
