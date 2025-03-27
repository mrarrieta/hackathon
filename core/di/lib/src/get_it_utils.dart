import 'package:get_it/get_it.dart';

extension GetItUtils on GetIt {
  void registerLazySingletonIfAbsent<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    if (!isRegistered<T>(instanceName: instanceName)) {
      registerLazySingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );
    }
  }
}
