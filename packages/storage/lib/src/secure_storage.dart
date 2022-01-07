import 'dart:convert';

import 'package:abstractions/abstractions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reactive/reactive.dart';
import 'package:storage/src/vault.dart';

class SecureStorage implements Vault {
  /// The id of the storage, e.g.: documents, credentials, etc
  final String storageId;
  final Map<String, dynamic> _data;
  final FlutterSecureStorage _storage;

  final Lock _modificationsLock = Lock();

  SecureStorage._(
    this.storageId,
    this._storage,
    Map<String, dynamic>? data,
  ) : _data = data ?? {};

  static Future<SecureStorage> open({required String storageId}) async {
    final storage = const FlutterSecureStorage();
    var data = <String, dynamic>{};
    final values = await storage.read(key: storageId);
    if (values?.isNotEmpty == true) {
      data = jsonDecode(values!) as Map<String, dynamic>;
    }
    return SecureStorage._(storageId, storage, data);
  }

  /// Add a new data to the storage, returns the written data
  @override
  MapEntry<String, dynamic> put({required dynamic data, required String id}) {
    _applyModifications(modifications: () {
      _data[id] = data;
      return _data;
    }, onError: () {
      _data.remove(id);
    });
    return MapEntry(id, data);
  }

  /// Delete a existing data of the storage, returns the ID if found
  @override
  String? delete({required String id}) {
    if (!_data.containsKey(id)) return null;
    final value = _data[id];

    _applyModifications(modifications: () {
      _data.remove(id);
      return _data;
    }, onError: () {
      _data[id] = value;
    });
    return id;
  }

  /// Clear all existing data of the storage
  @override
  void clear() {
    final copy = {..._data};
    _applyModifications(modifications: () {
      _data.clear();
      return _data;
    }, onError: () {
      _data.addAll(copy);
    });
  }

  /// Get a existing data of the storage, returns the data if it exists
  @override
  dynamic get({required String id}) => _data[id];

  /// List all data of the storage, returns a list
  @override
  List<dynamic> list() => _data.values.toList();

  Future<Either<Failure, void>> _applyModifications({
    required void Function() onError,
    required Map<String, dynamic> Function() modifications,
  }) async {
    return _modificationsLock.synchronized(() async {
      try {
        final string = jsonEncode(modifications());
        await _storage.write(key: storageId, value: string);
        return Right(null);
      } catch (e) {
        onError();
        return Left(Failure(message: e.toString()));
      }
    });
  }
}
