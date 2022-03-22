import 'dart:async';

import 'package:eve_core/eve_core.dart';
import 'package:example/micro_app_counter/counter_i18n_module.dart';
import 'package:example/micro_app_counter/counter_navigation_module.dart';
import 'package:example/micro_app_counter/data/counter_repository.dart';
import 'package:example/micro_app_counter/domain/repositories/counter_repository.dart';
import 'package:example/micro_app_counter/presentation/counter_view_model.dart';

class MicroAppCounter implements MicroApp {
  static const _vaultKey = 'counter';

  @override
  EveI18nModule get i18nModule => CounterI18nModule(packageName);

  @override
  FutureOr<void> dispose() {}

  @override
  FutureOr<void> initialize() async {
    final vault = Vault(storageId: _vaultKey);
    Injector().registerSingleton<Vault>(vault);
    Injector()
        .registerFactory<CounterRepository>(() => CounterRepositoryImpl(vault));
    Injector().registerSingleton<CounterViewModel>(CounterViewModel());
  }

  @override
  EveNavigationModule get navigatorModule => CounterNavigatorModule();

  @override
  String get packageName => 'counter';
}
