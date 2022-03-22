import 'package:eve_core/src/domain/entities/either.dart';
import 'package:eve_core/src/domain/entities/failure.dart';

abstract class EveRepository {
  Either<Failure, String?> getCurrentLanguage();
  Either<Failure, void> setCurrentLanguage(String language);
  Either<Failure, bool?> isDarkTheme();
  Either<Failure, void> setIsDarkTheme(bool darkTheme);
}
