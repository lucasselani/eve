import 'package:eve/eve.dart';
import 'package:example/base_app/base_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    EveApp(
      baseApp: BaseAppImpl(),
      theme: EveTheme.light(
          backgroundColor: Colors.white,
          primaryColor: Colors.blue,
          contentColor: Colors.black),
      darkTheme: EveTheme.dark(
          backgroundColor: Colors.black87,
          primaryColor: Colors.lightGreen,
          contentColor: Colors.white),
      defaultLanguage: const Locale('pt', 'BR'),
      supportedLanguages: const [Locale('pt', 'BR'), Locale('en')],
    ),
  );
}
