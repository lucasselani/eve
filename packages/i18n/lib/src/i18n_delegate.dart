import 'package:flutter/material.dart';
import 'package:i18n/src/i18n_module.dart';
import 'package:i18n/src/silencer.dart';

class I18nDelegate extends LocalizationsDelegate<Silencer> {
  final Locale defaultLanguage;
  final List<Locale> supportedLanguages;
  final List<I18nModule> i18nModules;

  const I18nDelegate({
    required this.defaultLanguage,
    required this.supportedLanguages,
    required this.i18nModules,
  });

  @override
  bool isSupported(Locale locale) => isLanguageSupported(locale);

  @override
  Future<Silencer> load(Locale locale) async {
    Locale chosenLocale;

    if (isLanguageAndCountrySupported(locale)) {
      chosenLocale = locale;
    } else if (isLanguageSupported(locale)) {
      chosenLocale = Locale(locale.languageCode);
    } else {
      chosenLocale = defaultLanguage;
    }

    final i18nMaps = await _loadMaps(locale: chosenLocale);
    return Silencer(
      i18nMaps,
      chosenLocale,
      defaultLanguage,
      supportedLanguages,
    );
  }

  @override
  bool shouldReload(I18nDelegate old) => false;

  bool isLanguageAndCountrySupported(Locale locale) =>
      supportedLanguages.any((language) =>
          language.countryCode == locale.countryCode &&
          language.languageCode == locale.languageCode);

  bool isLanguageSupported(Locale locale) => supportedLanguages
      .any((language) => language.languageCode == locale.languageCode);

  Future<Map<String, Map<String, String>>> _loadMaps(
      {required Locale locale}) async {
    final allModuleStrings = <String, Map<String, String>>{};

    for (final module in i18nModules) {
      allModuleStrings[module.packageName] =
          module.internationalStrings[locale] ??
              module.internationalStrings[defaultLanguage] ??
              {};
    }

    return allModuleStrings;
  }
}
