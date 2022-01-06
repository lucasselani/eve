import 'package:eve/src/di/tinker.dart';

typedef ObjectFactory<T> = T Function(Tinker keeper);

class TypeFactory<T> {
  final bool _isSingleton;
  final ObjectFactory<T> _objectFactory;
  T? _instance;

  TypeFactory(this._objectFactory, this._isSingleton);

  T get(Tinker keeper) {
    if (_isSingleton && _instance != null) {
      return _instance!;
    }

    final instance = _objectFactory(keeper);
    if (_isSingleton) {
      _instance = instance;
    }
    return instance;
  }
}
