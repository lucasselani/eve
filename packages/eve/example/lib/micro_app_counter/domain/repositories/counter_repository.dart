import 'package:eve/eve.dart';

abstract class CounterRepository {
  Either<Failure, int> getCount();
  Either<Failure, void> setCount(int count);
}
