import 'package:di/di.dart';
import 'package:base_redux/redux.dart';
import 'package:flutter/material.dart';

class DependenciesUtils {
  const DependenciesUtils._();

  static Set<LocalizationsDelegate> getLocalizationsDelegates(
    Set<DependenciesDelegate> delegates,
  ) {
    final result = <LocalizationsDelegate>{};
    for (final delegate in delegates) {
      final l10nDependencies = delegate.localizationsDependencies;
      if (l10nDependencies != null) {
        result.add(l10nDependencies.localizationsDelegate);
      }
    }
    return result;
  }

  static Set<Locale> getSupportedLocales(
    Set<DependenciesDelegate> delegates,
  ) {
    var result = <Locale>{};

    final filteredSupportedLocales = <Set<Locale>>[];
    for (final delegate in delegates) {
      final supportedLocales =
          delegate.localizationsDependencies?.supportedLocales;
      if (supportedLocales != null) {
        filteredSupportedLocales.add(supportedLocales);
      }
    }

    result.addAll(filteredSupportedLocales.first);
    for (final supportedLocales in filteredSupportedLocales) {
      if (supportedLocales.isNotEmpty) {
        result = result.intersection(supportedLocales);
      }
    }
    return result;
  }

  static Set<Middleware<T>> getMiddlewares<T>(
    Set<DependenciesDelegate<T>> delegates,
  ) {
    final result = <Middleware<T>>{};
    for (final delegate in delegates) {
      result.addAll(delegate.middlewares);
    }
    return result;
  }

  static Future<void> registerDependencies<T>(
    GetIt getIt,
    Set<DependenciesDelegate<T>> delegates,
  ) async {
    for (final delegate in delegates) {
      await delegate.registerDependencies(getIt);
    }
  }
}
