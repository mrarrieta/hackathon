import 'package:ai_project/routes.dart';
import 'package:locale/l10n/core_localizations.dart';
import 'package:flutter/material.dart';

class AiProjectApp extends StatelessWidget {
  const AiProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AI',
      localizationsDelegates: CoreLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('es'),
      ],
      routerConfig: Routes.router,
    );
  }
}
