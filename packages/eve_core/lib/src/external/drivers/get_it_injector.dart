import 'package:eve_core/src/data/drivers/injector.dart';
import 'package:get_it/get_it.dart';

class GetItInjector implements Injector {
  final _getIt = GetIt.I;

  @override
  T get<T extends Object>() => _getIt.get<T>();

  @override
  bool isRegistered<T extends Object>({Object? instance}) =>
      _getIt.isRegistered<T>(instance: instance);

  @override
  void registerFactory<T extends Object>(FactoryFunction<T> factoryFunc) =>
      _getIt.registerFactory<T>(factoryFunc);

  @override
  void registerSingleton<T extends Object>(T instance) =>
      _getIt.registerSingleton<T>(instance);

  @override
  Future<void> reset() => _getIt.reset();

  @override
  void unregister<T extends Object>({Object? instance}) =>
      _getIt.unregister<T>(instance: instance);
}
