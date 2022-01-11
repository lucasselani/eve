import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/domain/repositories/counter_repository.dart';

class UseCaseGetCount implements UseCase<int> {
  @override
  Either<Failure, int> run() => Injector().get<CounterRepository>().getCount();
}

class UseCaseSetCount implements UseCase<void> {
  final int count;

  UseCaseSetCount(this.count);

  @override
  Either<Failure, void> run() =>
      Injector().get<CounterRepository>().setCount(count);
}
