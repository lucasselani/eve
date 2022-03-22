import 'dart:io';

import 'package:eve_core/src/data/drivers/injector.dart';
import 'package:eve_core/src/domain/repositories/eve_repository.dart';
import 'package:flutter/material.dart';

class EveManagerUseCases {
  bool isDarkTheme() {
    final result = Injector().get<EveRepository>().isDarkTheme();
    if (result.rightOrNull == null) return false;
    return result.right!;
  }

  void setDarkTheme({required bool isDarkTheme}) {
    Injector().get<EveRepository>().setIsDarkTheme(isDarkTheme);
  }

  Locale getCurrentLanguage({required Locale defaultLanguage}) {
    final result = Injector().get<EveRepository>().getCurrentLanguage();
    final locale =
        result.rightOrNull == null ? Platform.localeName : result.right!;
    final appLocaleArray = locale.split('_');
    return appLocaleArray.isEmpty
        ? defaultLanguage
        : Locale(appLocaleArray.first,
            appLocaleArray.length > 1 ? appLocaleArray[1] : null);
  }

  void setCurrentLanguage({required Locale currentLanguage}) {
    Injector()
        .get<EveRepository>()
        .setCurrentLanguage(currentLanguage.toString());
  }
}
