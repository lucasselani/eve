import 'package:flutter/material.dart';
import 'package:i18n/src/eve_i18n_module.dart';
import 'package:i18n/src/eve_translator.dart';

class EveI18nDelegate extends LocalizationsDelegate<EveTranslator> {
  final Locale defaultLanguage;
  final List<Locale> supportedLanguages;
  final List<EveI18nModule> i18nModules;

  const EveI18nDelegate({
    required this.defaultLanguage,
    required this.supportedLanguages,
    required this.i18nModules,
  });

  @override
  bool isSupported(Locale locale) => isLanguageSupported(locale);

  @override
  Future<EveTranslator> load(Locale locale) async {
    Locale chosenLocale;

    if (isLanguageAndCountrySupported(locale)) {
      chosenLocale = locale;
    } else if (isLanguageSupported(locale)) {
      chosenLocale = Locale(locale.languageCode);
    } else {
      chosenLocale = defaultLanguage;
    }

    final i18nMaps = await _loadMaps(locale: chosenLocale);
    return EveTranslator(
      i18nMaps,
      chosenLocale,
      defaultLanguage,
      supportedLanguages,
    );
  }

  @override
  bool shouldReload(EveI18nDelegate old) => false;

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
