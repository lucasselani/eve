import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/domain/use_cases/counter_use_cases.dart';

class CounterViewModel {
  final Observable<int> count = Observable();

  CounterViewModel() {
    _init();
  }

  void _init() {
    final result = UseCaseGetCount().run();
    if (result.rightOrNull != null) {
      count.toSuccess(result.right);
    }
  }

  void increment() {
    final previousValue = count.value.isSuccess ? count.value.data! : 0;
    final newValue = previousValue + 1;
    count.toSuccess(newValue);
    UseCaseSetCount(newValue).run();
  }
}
