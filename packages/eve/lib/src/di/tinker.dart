import 'package:eve/src/di/type_factory.dart';

class Tinker {
  static final Map<String, Tinker> _keepers = <String, Tinker>{};
  final Map<String, TypeFactory<Object>> _factories =
      <String, TypeFactory<Object>>{};

  final String name;

  factory Tinker([String name = 'default']) {
    if (!_keepers.containsKey(name)) {
      _keepers[name] = Tinker._(name);
    }

    return _keepers[name]!;
  }

  Tinker._(this.name);

  String _makeKey<T extends Object>(T type, [String? key]) =>
      '${_makeKeyPrefix(type)}${key ?? 'default'}';

  String _makeKeyPrefix<T extends Object>(T type) => '${type.toString()}::';

  Tinker map<T extends Object>(ObjectFactory<T> objectFactory,
      {bool isSingleton = false, String? key}) {
    final objectKey = _makeKey(T, key);
    if (!_factories.containsKey(objectKey)) {
      _factories[objectKey] =
          TypeFactory<T>((tinker) => objectFactory(tinker), isSingleton);
    }
    return this;
  }

  bool isMapped<T extends Object>({String? key}) {
    final objectKey = _makeKey(T, key);
    return _factories.containsKey(objectKey);
  }

  Tinker remove<T extends Object>({String? key}) {
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
    return objectFactory.get(this) as T;
  }

  void dispose() {
    _factories.clear();
    _keepers.remove(name);
  }
}
