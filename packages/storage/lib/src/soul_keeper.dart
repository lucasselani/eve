import 'dart:convert';

import 'package:abstractions/abstractions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Use this Datasource inside a @Singleton or @LazySingleton class to keep the data loaded all the time to boost performance
/// If you want to use it outside a singleton environment, keep in mind that the data will be fetched every time you use any function
class SoulKeeper {
  /// The id of the storage, e.g.: documents, credentials, etc
  String storageId;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Map<String, dynamic> _data = {};
  bool _isInitialized = false;

  SoulKeeper({required this.storageId});

  /// Add a new data to the storage, returns the written data
  Future<Either<Failure, dynamic>> put(
      {required dynamic data, required String id}) async {
    final initialization = await _initialize();
    if (initialization.isLeft) return initialization;

    _data[id] = data;
    final result = await _applyModifications();
    if (result.isRight) return Right(data);

    _data.remove(id);
    return result;
  }

  /// Delete a existing data of the storage
  Future<Either<Failure, void>> delete({required String id}) async {
    final initialization = await _initialize();
    if (initialization.isLeft) return initialization;

    if (!_data.containsKey(id)) return Right(null);

    final value = _data[id];
    _data.remove(id);
    final result = await _applyModifications();
    if (result.isRight) return Right(id);

    _data[id] = value;
    return result;
  }

  /// Delete all data of the storage
  Future<Either<Failure, void>> clear() async {
    try {
      await _storage.delete(key: storageId);
      _data.clear();
      _isInitialized = false;
      return Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  /// Get a existing data of the storage, returns the data if it exists
  Future<Either<Failure, dynamic>> get({required String id}) async {
    final initialization = await _initialize();
    if (initialization.isLeft) return initialization;

    return Right(_data[id]);
  }

  /// List all data of the storage
  Future<Either<Failure, List<dynamic>>> list() async {
    final initialization = await _initialize();
    if (initialization.isLeft) return Left(initialization.left);

    return Right(_data.values.toList());
  }

  Future<Either<Failure, void>> _initialize() async {
    if (_isInitialized) return Right(_data);
    try {
      _data.clear();
      final values = await _storage.read(key: storageId);
      if (values?.isNotEmpty == true) {
        final json = jsonDecode(values!) as Map<String, dynamic>;
        _data.addAll(json);
      }
      _isInitialized = true;
      return Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> _applyModifications() async {
    try {
      final string = jsonEncode(_data);
      await _storage.write(key: storageId, value: string);
      return Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
