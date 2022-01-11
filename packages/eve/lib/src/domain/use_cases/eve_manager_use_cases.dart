import 'dart:io';

import 'package:eve/eve.dart';
import 'package:eve/src/domain/repositories/eve_repository.dart';
import 'package:flutter/material.dart';

class UseCaseIsDarkTheme implements UseCase<bool> {
  @override
  bool run() {
    final result = Injector('eveApp').get<EveRepository>().isDarkTheme();
    if (result.rightOrNull == null) return false;
    return result.right!;
  }
}

class UseCaseSetIsDarkTheme implements UseCase<void> {
  final bool isDarkTheme;

  UseCaseSetIsDarkTheme(this.isDarkTheme);

  @override
  void run() {
    Injector('eveApp').get<EveRepository>().setIsDarkTheme(isDarkTheme);
  }
}

class UseCaseGetCurrentLanguage implements UseCase<Locale> {
  final Locale defaultLanguage;

  UseCaseGetCurrentLanguage(this.defaultLanguage);

  @override
  Locale run() {
    final result = Injector('eveApp').get<EveRepository>().getCurrentLanguage();
    if (result.rightOrNull == null) {
      final appLocaleArray = Platform.localeName.split('_');
      return appLocaleArray.isEmpty
          ? defaultLanguage
          : Locale(appLocaleArray.first,
              appLocaleArray.length > 1 ? appLocaleArray[1] : null);
    } else {
      final appLocaleArray = result.right!.split('_');
      return appLocaleArray.isEmpty
          ? defaultLanguage
          : Locale(appLocaleArray.first,
              appLocaleArray.length > 1 ? appLocaleArray[1] : null);
    }
  }
}

class UseCaseSetCurrentLanguage implements UseCase<void> {
  final Locale currentLanguage;

  UseCaseSetCurrentLanguage(this.currentLanguage);

  @override
  void run() {
    Injector('eveApp')
        .get<EveRepository>()
        .setCurrentLanguage(currentLanguage.toString());
  }
}
