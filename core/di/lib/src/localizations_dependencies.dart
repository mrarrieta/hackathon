import 'package:flutter/cupertino.dart';

class LocalizationsDependencies {
  final LocalizationsDelegate localizationsDelegate;
  final Set<Locale> supportedLocales;

  const LocalizationsDependencies({
    required this.localizationsDelegate,
    required this.supportedLocales,
  });
}
