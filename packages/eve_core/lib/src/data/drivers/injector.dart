import 'package:eve_core/src/external/drivers/get_it_injector.dart';

typedef FactoryFunction<T> = T Function();

abstract class Injector {
  factory Injector() => GetItInjector();

  /// registers a type so that a new instance will be created on each call of [get] on that type
  /// [T] type to register
  /// [factoryFunc] factory function for this type
  void registerFactory<T extends Object>(FactoryFunction<T> factoryFunc);

  /// registers a type as Singleton by passing an [instance] of that type
  /// that will be returned on each call of [get] on that type
  /// [T] type to register
  void registerSingleton<T extends Object>(T instance);

  /// retrieves or creates an instance of a registered type [T] depending on
  /// the registration function used for this type.
  T get<T extends Object>();

  /// Tests if an [instance] of an object or aType [T] is registered
  bool isRegistered<T extends Object>({Object? instance});

  /// Unregister an [instance] of an object or a factory/singleton by Type [T] or by name
  void unregister<T extends Object>({Object? instance});

  /// Clears all registered types. Handy when writing unit tests
  Future<void> reset();
}
