import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dependencies_utils_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DependenciesDelegate<String>>(),
  MockSpec<LocalizationsDelegate>(),
])
void main() {
  late DependenciesDelegate<String> delegate1;
  late DependenciesDelegate<String> delegate2;
  late DependenciesDelegate<String> delegate3;

  setUp(() {
    delegate1 = MockDependenciesDelegate();
    delegate2 = MockDependenciesDelegate();
    delegate3 = MockDependenciesDelegate();
  });

  group('getLocalizationsDelegates', () {
    test('return non-null localizations delegates in delegates set', () {
      final localizationsDelegate1 = MockLocalizationsDelegate();
      final localizationsDelegate3 = MockLocalizationsDelegate();
      final supportedLocales = {const Locale('en')};

      when(delegate1.localizationsDependencies).thenReturn(
        LocalizationsDependencies(
          localizationsDelegate: localizationsDelegate1,
          supportedLocales: supportedLocales,
        ),
      );
      when(delegate2.localizationsDependencies).thenReturn(null);
      when(delegate3.localizationsDependencies).thenReturn(
        LocalizationsDependencies(
          localizationsDelegate: localizationsDelegate3,
          supportedLocales: supportedLocales,
        ),
      );

      final result = DependenciesUtils.getLocalizationsDelegates({
        delegate1,
        delegate2,
        delegate3,
      });

      expect(result, [localizationsDelegate1, localizationsDelegate3]);
    });
  });

  group('getSupportedLocales', () {
    test('return intersection of locales excluding empty supported locales', () {
      final localizationsDelegate1 = MockLocalizationsDelegate();
      final localizationsDelegate2 = MockLocalizationsDelegate();
      final localizationsDelegate3 = MockLocalizationsDelegate();
      const en = Locale('en');
      const es = Locale('es');

      when(delegate1.localizationsDependencies).thenReturn(
        LocalizationsDependencies(
          localizationsDelegate: localizationsDelegate1,
          supportedLocales: {en},
        ),
      );
      when(delegate2.localizationsDependencies).thenReturn(
        LocalizationsDependencies(
          localizationsDelegate: localizationsDelegate2,
          supportedLocales: {},
        ),
      );
      when(delegate3.localizationsDependencies).thenReturn(
        LocalizationsDependencies(
          localizationsDelegate: localizationsDelegate3,
          supportedLocales: {en, es},
        ),
      );

      final result = DependenciesUtils.getSupportedLocales({
        delegate1,
        delegate2,
        delegate3,
      });

      expect(result, {en});
    });
  });

  group('getMiddlewares', () {
    test('return list of all middlewares', () {
      middleware1a(_, __, ___) {}
      middleware1b(_, __, ___) {}
      middleware3(_, __, ___) {}
      when(delegate1.middlewares).thenReturn({middleware1a, middleware1b});
      when(delegate2.middlewares).thenReturn({});
      when(delegate3.middlewares).thenReturn({middleware3});

      final result = DependenciesUtils.getMiddlewares({
        delegate1,
        delegate2,
        delegate3,
      });

      expect(result, [middleware1a, middleware1b, middleware3]);
    });
  });
}
