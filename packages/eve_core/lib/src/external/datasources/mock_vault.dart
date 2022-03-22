import 'package:eve_core/src/data/datasources/vault.dart';

class MockVault implements Vault {
  final Map<String, dynamic> _values = const {};

  const MockVault();

  @override
  void clear() {
    _values.clear();
  }

  @override
  void delete({required String id}) => _values.remove(id);

  @override
  T get<T extends Object>({required String id}) => _values[id];

  @override
  void put<T extends Object>({required T data, required String id}) {
    _values[id] = data;
  }
}
