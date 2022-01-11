import 'dart:ui';

import 'package:eve/eve.dart';

class BaseAppI18nModule extends EveI18nModule {
  BaseAppI18nModule(String packageName) : super(packageName);

  @override
  Map<Locale, Map<String, String>> get internationalStrings => {
        const Locale('pt', 'BR'): {
          'increment': 'Acrescentar',
          'splash_screen_text': 'Iniciando o aplicativo...'
        },
        const Locale('en'): {
          'increment': 'Increment',
          'splash_screen_text': 'Starting the app...'
        }
      };
}
