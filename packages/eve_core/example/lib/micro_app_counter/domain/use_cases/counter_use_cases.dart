import 'package:eve_core/eve_core.dart';
import 'package:example/micro_app_counter/domain/repositories/counter_repository.dart';

class UseCaseGetCount {
  UseCase<int> run() => Injector().get<CounterRepository>().getCount();
}

class UseCaseSetCount {
  final int count;

  UseCaseSetCount(this.count);

  UseCase<void> run() => Injector().get<CounterRepository>().setCount(count);
}
