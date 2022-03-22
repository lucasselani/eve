import 'package:eve_core/eve_core.dart';
import 'package:flutter/material.dart';

class CounterI18nModule extends EveI18nModule {
  CounterI18nModule(String packageName) : super(packageName);

  @override
  Map<Locale, Map<String, String>> get internationalStrings => {
        const Locale('pt', 'BR'): {
          'button_pushed': 'Você apertou o botão tantas vezes:',
          'counter_title': 'Contador'
        },
        const Locale('en'): {
          'button_pushed': 'You have pushed the button this many times:',
          'counter_title': 'Counter'
        }
      };
}
