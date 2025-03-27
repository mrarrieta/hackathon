import 'package:flutter/material.dart';

import 'core_localizations.dart';

extension CoreLocalizationsX on BuildContext {
  CoreLocalizations get l10n {
    final l10n = CoreLocalizations.of(this);
    if (l10n != null) return l10n;
    throw Exception(
      'Did you forget to add this localization delegate to material app?',
    );
  }
}
