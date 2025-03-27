import 'package:di/di.dart';
import 'package:base_redux/redux.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'By default, dependencies delegate are compared by runtimeType, so they are added individually to set',
    () {
      final obj1 = DependenciesDelegate1();
      final obj2 = DependenciesDelegate1();
      final obj3 = DependenciesDelegate2();

      final set = {obj1, obj2, obj3};

      expect(set.length, 2);
      expect(set, containsAll([obj1, obj3]));
    },
  );
}

class DependenciesDelegate1 extends DependenciesDelegate<String> {
  @override
  LocalizationsDependencies? get localizationsDependencies =>
      throw UnimplementedError();

  @override
  Future<void> registerDependencies(GetIt getIt) async {}

  @override
  Set<Middleware<String>> get middlewares => throw UnimplementedError();
}

class DependenciesDelegate2 extends DependenciesDelegate<String> {}
