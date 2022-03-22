import 'package:eve_core/src/domain/entities/either.dart';
import 'package:eve_core/src/presentation/navigator/eve_navigator.dart';
import 'package:flutter/material.dart';

class TranslatorLanguages {
  final Locale currentLanguage;
  final Locale defaultLanguage;
  final List<Locale> supportedLanguages;

  TranslatorLanguages(
      this.currentLanguage, this.defaultLanguage, this.supportedLanguages);
}

class EveTranslator {
  static const _unregisteredValueError = 'error: unregistered value';
  static const _invalidContextError = 'error: invalid context';

  final Map<String, Map<String, String>> _localizedMaps;
  final TranslatorLanguages _languages;

  EveTranslator(
    this._localizedMaps,
    Locale currentLanguage,
    Locale defaultLanguage,
    List<Locale> supportedLanguages,
  ) : _languages = TranslatorLanguages(
            currentLanguage, defaultLanguage, supportedLanguages);

  static TranslatorLanguages? languages({BuildContext? context}) {
    final currentContext = context ?? EveNavigator().context;
    if (currentContext == null) return null;

    final translator =
        Localizations.of<EveTranslator>(currentContext, EveTranslator);
    return translator?._languages;
  }

  static String translate(
      {required String key,
      BuildContext? context,
      String? package,
      List<String> args = const []}) {
    final currentContext = context ?? EveNavigator().context;
    if (currentContext == null) return _invalidContextError;

    final translator =
        Localizations.of<EveTranslator>(currentContext, EveTranslator);
    if (translator == null) return _invalidContextError;

    final result = _getValue(
      package: package,
      key: key,
      translator: translator,
    );
    if (result.isLeft) return result.left;
    return _addArgs(value: result.right, args: args);
  }

  static Either<String, String> _getValue({
    required String? package,
    required String key,
    required EveTranslator translator,
  }) {
    if (package?.isNotEmpty == true) {
      final value = translator._localizedMaps[package!]?[key];
      return value != null
          ? Right(value)
          : Left('$_unregisteredValueError in $package package');
    }

    for (final packageStrings in translator._localizedMaps.values) {
      if (packageStrings.containsKey(key) == true) {
        return Right(packageStrings[key]!);
      }
    }

    return Left(_unregisteredValueError);
  }

  static String _addArgs({required String value, required List<String> args}) {
    var index = 0;
    while (value.contains('%s') && index < args.length) {
      value = value.replaceFirst('%s', args[index]);
      index++;
    }
    return value.replaceAll('%s', '');
  }
}
