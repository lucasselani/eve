import 'package:abstractions/abstractions.dart';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';

class SilencerLanguages {
  final Locale currentLanguage;
  final Locale defaultLanguage;
  final List<Locale> supportedLanguages;

  SilencerLanguages(
      this.currentLanguage, this.defaultLanguage, this.supportedLanguages);
}

class Silencer {
  static const _unregisteredValueError = 'error: unregistered value';
  static const _invalidContextError = 'error: invalid context';

  final Map<String, Map<String, String>> _localizedMaps;
  final SilencerLanguages _languages;

  Silencer(
    this._localizedMaps,
    Locale currentLanguage,
    Locale defaultLanguage,
    List<Locale> supportedLanguages,
  ) : _languages = SilencerLanguages(
            currentLanguage, defaultLanguage, supportedLanguages);

  static SilencerLanguages? languages({BuildContext? context}) {
    final currentContext = context ?? Admiral().context;
    if (currentContext == null) return null;

    final silencer = Localizations.of<Silencer>(currentContext, Silencer);
    return silencer?._languages;
  }

  static String translate(
      {required String key,
      BuildContext? context,
      String? package,
      List<String> args = const []}) {
    final currentContext = context ?? Admiral().context;
    if (currentContext == null) return _invalidContextError;

    final silencer = Localizations.of<Silencer>(currentContext, Silencer);
    if (silencer == null) return _invalidContextError;

    final result = _getValue(
      package: package,
      key: key,
      silencer: silencer,
    );
    if (result.isLeft) return result.left;
    return _addArgs(value: result.right, args: args);
  }

  static Either<String, String> _getValue({
    required String? package,
    required String key,
    required Silencer silencer,
  }) {
    if (package?.isNotEmpty == true) {
      final value = silencer._localizedMaps[package!]?[key];
      return value != null
          ? Right(value)
          : Left('$_unregisteredValueError in $package package');
    }

    for (final packageStrings in silencer._localizedMaps.values) {
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
