import 'package:flutter/material.dart';

abstract class EveI18nModule {
  final String packageName;

  EveI18nModule(this.packageName);

  Map<Locale, Map<String, String>> get internationalStrings;
}
