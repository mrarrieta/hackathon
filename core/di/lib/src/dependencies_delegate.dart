import 'package:di/di.dart';
import 'package:base_redux/redux.dart';
import 'package:equatable/equatable.dart';

abstract class DependenciesDelegate<S> extends Equatable {
  const DependenciesDelegate();

  LocalizationsDependencies? get localizationsDependencies => null;

  Future<void> registerDependencies(GetIt getIt) async {}

  Set<Middleware<S>> get middlewares => {};

  @override
  List<Object?> get props => [];
}
