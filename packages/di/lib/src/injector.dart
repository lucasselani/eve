import 'package:di/src/type_factory.dart';

class Injector {
  static final Map<String, Injector> _injectors = <String, Injector>{};
  final Map<String, TypeFactory<Object>> _factories =
      <String, TypeFactory<Object>>{};

  final String name;

  factory Injector([String name = 'default']) {
    if (!_injectors.containsKey(name)) {
      _injectors[name] = Injector._(name);
    }

    return _injectors[name]!;
  }

  Injector._(this.name);

  String _makeKey<T extends Object>(T type, [String? key]) =>
      '${_makeKeyPrefix(type)}${key ?? 'default'}';

  String _makeKeyPrefix<T extends Object>(T type) => '${type.toString()}::';

  Injector map<T extends Object>(ObjectFactory<T> objectFactory,
      {bool isSingleton = false, String? key}) {
    final objectKey = _makeKey(T, key);
    if (!_factories.containsKey(objectKey)) {
      _factories[objectKey] =
          TypeFactory<T>(() => objectFactory(), isSingleton);
    }
    return this;
  }

  bool isMapped<T extends Object>({String? key}) {
    final objectKey = _makeKey(T, key);
    return _factories.containsKey(objectKey);
  }

  Injector remove<T extends Object>({String? key}) {
    final objectKey = _makeKey(T, key);
    if (_factories.containsKey(objectKey)) {
      _factories.remove(objectKey);
    }
    return this;
  }

  T get<T extends Object>({String? key}) {
    final objectKey = _makeKey(T, key);
    final objectFactory = _factories[objectKey];
    if (objectFactory == null) {
      throw Exception("Cannot find object factory for '$objectKey'");
    }
    return objectFactory.get() as T;
  }

  void dispose() {
    _factories.clear();
    _injectors.remove(name);
  }
}
