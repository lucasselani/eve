import 'package:eve_core/eve_core.dart';

abstract class CounterRepository {
  Either<Failure, int> getCount();
  Either<Failure, void> setCount(int count);
}
