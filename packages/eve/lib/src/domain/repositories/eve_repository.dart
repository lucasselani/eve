import 'package:eve/eve.dart';

abstract class EveRepository {
  Either<Failure, String?> getCurrentLanguage();
  Either<Failure, void> setCurrentLanguage(String language);
  Either<Failure, bool?> isDarkTheme();
  Either<Failure, void> setIsDarkTheme(bool darkTheme);
}
