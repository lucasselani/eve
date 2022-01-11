import 'package:eve/eve.dart';

import 'package:eve/src/domain/repositories/eve_repository.dart';

class EveRepositoryImpl implements EveRepository {
  static const _darkThemeKey = 'darkTheme';
  static const _languageKey = 'language';

  final Vault vault;

  EveRepositoryImpl(this.vault);

  @override
  Either<Failure, bool> isDarkTheme() {
    final result = vault.get(id: _darkThemeKey) as bool?;
    if (result == null) {
      return Left(Failure(message: 'no value is present for darkTheme'));
    } else {
      return Right(result);
    }
  }

  @override
  Either<Failure, void> setIsDarkTheme(bool darkTheme) {
    vault.put(data: darkTheme, id: _darkThemeKey);
    return Right(null);
  }

  @override
  Either<Failure, String?> getCurrentLanguage() {
    final result = vault.get(id: _languageKey) as String?;
    if (result == null) {
      return Left(Failure(message: 'no value is present for language'));
    } else {
      return Right(result);
    }
  }

  @override
  Either<Failure, void> setCurrentLanguage(String language) {
    vault.put(data: language, id: _languageKey);
    return Right(null);
  }
}
