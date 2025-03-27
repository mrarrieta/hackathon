import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';

import '../data/splash_api.dart';

class SplashContent extends StatelessWidget {
  const SplashContent(this._splashResponse, {super.key});

  final SplashResponse? _splashResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        if(_splashResponse == null) const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(width: 30, height: 30, child: CircularProgressIndicator())]
        ),
        if(_splashResponse != null) Column(children: [
          Image.memory(base64Decode(_splashResponse!.image!)),
          const SizedBox(height: 20),
          Text(_splashResponse!.randomSentence ?? context.l10n.splashError),
        ],),
        const Spacer(flex: 1),
      ],
    );
  }
}
