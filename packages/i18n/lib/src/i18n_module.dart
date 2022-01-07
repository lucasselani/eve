import 'package:flutter/material.dart';

abstract class I18nModule {
  final String packageName;

  I18nModule(this.packageName);

  Map<Locale, Map<String, String>> get internationalStrings;
}
