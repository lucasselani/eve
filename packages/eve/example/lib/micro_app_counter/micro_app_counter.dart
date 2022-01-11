import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/counter_i18n_module.dart';
import 'package:example/micro_app_counter/counter_navigation_module.dart';
import 'package:example/micro_app_counter/data/counter_repository.dart';
import 'package:example/micro_app_counter/domain/repositories/counter_repository.dart';
import 'package:example/micro_app_counter/presentation/counter_view_model.dart';

class MicroAppCounter implements MicroApp {
  static const _vaultKey = 'counter';

  @override
  Future<void> dispose() async {}

  @override
  EveI18nModule get i18nModule => CounterI18nModule(packageName);

  @override
  Future<void> initialize() async {
    final vault = await Vault.open(storageId: _vaultKey);
    Injector()
        .map<Vault>(() => vault, isSingleton: true, key: 'vault_$_vaultKey');
    Injector().map<CounterRepository>(() => CounterRepositoryImpl(vault));
    Injector()
        .map<CounterViewModel>(() => CounterViewModel(), isSingleton: true);
  }

  @override
  EveNavigationModule get navigatorModule => CounterNavigatorModule();

  @override
  String get packageName => 'counter';
}
