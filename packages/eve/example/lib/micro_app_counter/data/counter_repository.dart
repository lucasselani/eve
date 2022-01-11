import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  static const _countKey = 'count';
  final Vault vault;

  CounterRepositoryImpl(this.vault);

  @override
  Either<Failure, int> getCount() {
    final value = vault.get(id: _countKey) as int?;
    if (value == null) {
      return Left(Failure(message: 'value doesnt exist'));
    } else {
      return Right(value);
    }
  }

  @override
  Either<Failure, void> setCount(int count) {
    vault.put(data: count, id: _countKey);
    return Right(null);
  }
}
