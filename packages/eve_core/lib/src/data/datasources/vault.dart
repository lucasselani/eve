import 'package:eve_core/src/external/datasources/mock_vault.dart';
import 'package:eve_core/src/external/datasources/shared_vault.dart';
import 'package:flutter/foundation.dart';

abstract class Vault {
  /// Put an [Object] inside the current [Vault] with a given id
  void put<T extends Object>({required T data, required String id});

  /// Delete a data from the current [Vault] with a given id
  void delete({required String id});

  /// Clear all values of the current [Vault]
  void clear();

  /// Get a value inside the current [Vault] with a given id of any type
  T get<T extends Object>({required String id});

  /// Create a new instance of the [Vault] with [storageId]
  /// The [storageId] is used to separate data from diferrent vaults
  factory Vault({required String storageId}) => SharedVault(storageId);

  /// Create a new instance of the [Vault] to use in testing
  @visibleForTesting
  factory Vault.createForTest({required String storageId}) => const MockVault();
}
