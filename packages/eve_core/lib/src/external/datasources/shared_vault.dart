import 'dart:convert';

import 'package:eve_core/src/data/datasources/vault.dart';
import 'package:eve_core/src/data/drivers/injector.dart';
import 'package:eve_core/src/domain/entities/either.dart';
import 'package:eve_core/src/domain/entities/failure.dart';
import 'package:eve_core/src/utils/lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedVault implements Vault {
  /// The id of the storage, e.g.: documents, credentials, etc
  final String storageId;

  final Map<String, dynamic> _data = {};
  final SharedPreferences _storage = Injector().get<SharedPreferences>();
  final Lock _modificationsLock = Lock();

  SharedVault(this.storageId) {
    final currentData = _storage.getString(storageId);
    if (currentData != null) {
      try {
        final base64bytes = base64Decode(currentData);
        final jsonString = utf8.decode(base64bytes);
        _data.addAll(jsonDecode(jsonString));
      } catch (_) {}
    }
  }

  @override
  void put<T extends Object>({required T data, required String id}) {
    _applyModifications(modifications: () {
      _data[id] = data;
      return _data;
    }, onError: () {
      _data.remove(id);
    });
  }

  @override
  void delete({required String id}) {
    if (!_data.containsKey(id)) return;
    final value = _data[id];

    _applyModifications(modifications: () {
      _data.remove(id);
      return _data;
    }, onError: () {
      _data[id] = value;
    });
  }

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

  @override
  T get<T extends Object>({required String id}) => _data[id];

  Future<Either<Failure, void>> _applyModifications({
    required void Function() onError,
    required Map<String, dynamic> Function() modifications,
  }) async {
    return _modificationsLock.synchronized(() async {
      try {
        final jsonString = jsonEncode(modifications());
        final jsonBytes = utf8.encode(jsonString);
        final base64String = base64Encode(jsonBytes);
        await _storage.setString(storageId, base64String);
        return Right(null);
      } catch (e) {
        onError();
        return Left(Failure(message: e.toString()));
      }
    });
  }
}
