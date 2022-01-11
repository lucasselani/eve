typedef ObjectFactory<T> = T Function();

class TypeFactory<T> {
  final bool _isSingleton;
  final ObjectFactory<T> _objectFactory;
  T? _instance;

  TypeFactory(this._objectFactory, this._isSingleton);

  T get() {
    if (_isSingleton && _instance != null) {
      return _instance!;
    }

    final instance = _objectFactory();
    if (_isSingleton) {
      _instance = instance;
    }
    return instance;
  }
}
