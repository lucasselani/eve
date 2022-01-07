import 'dart:io';

import 'package:storage/src/mock_storage.dart';
import 'package:storage/src/secure_storage.dart';

abstract class Vault {
  static final Map<String, Vault> _instances = {};

  MapEntry<String, dynamic> put({required dynamic data, required String id});
  String? delete({required String id});
  void clear();
  dynamic get({required String id});
  List<dynamic> list();

  /// Get and open instance of the Vault
  factory Vault({required String storageId}) {
    if (isOpen(storageId: storageId)) {
      return _instances[storageId]!;
    }
    throw Exception(
        'You need to call Vault.create for the $storageId id first');
  }

  /// Open/create the Vault
  static Future<Vault> open({required String storageId}) async {
    if (isOpen(storageId: storageId)) {
      return _instances[storageId]!;
    }
    final instance = Platform.environment.containsKey('FLUTTER_TEST')
        ? await MockStorage.open()
        : await SecureStorage.open(storageId: storageId);
    _instances[storageId] = instance;
    return instance;
  }

  /// Check if a Vault is open
  static bool isOpen({required String storageId}) =>
      _instances.containsKey(storageId);
}
