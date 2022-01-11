import 'package:flutter/foundation.dart';
import 'package:storage/src/mock_vault.dart';
import 'package:storage/src/secure_vault.dart';
import 'dart:developer';

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
    try {
      _instances[storageId] = await SecureVault.open(storageId: storageId);
      return _instances[storageId]!;
    } catch (e, stackTrace) {
      log('failed to open Vault', error: e, stackTrace: stackTrace);
    }

    return _instances[storageId]!;
  }

  @visibleForTesting
  static Future<Vault> openForTest({required String storageId}) async {
    if (isOpen(storageId: storageId)) {
      return _instances[storageId]!;
    }
    final instance = await MockVault.open();
    _instances[storageId] = instance;
    return instance;
  }

  /// Check if a Vault is open
  static bool isOpen({required String storageId}) =>
      _instances.containsKey(storageId);
}
