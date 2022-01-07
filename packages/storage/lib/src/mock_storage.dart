import 'package:storage/storage.dart';

class MockStorage implements Vault {
  final Map<String, dynamic> _values = const {};

  const MockStorage._();

  static Future<MockStorage> open() => Future.value(const MockStorage._());

  @override
  void clear() {
    _values.clear();
  }

  @override
  String? delete({required String id}) => _values.remove(id);

  @override
  dynamic get({required String id}) => _values[id];

  @override
  List<dynamic> list() => _values.values.toList();

  @override
  MapEntry<String, dynamic> put({required data, required String id}) {
    _values[id] = data;
    return MapEntry(id, data);
  }
}
