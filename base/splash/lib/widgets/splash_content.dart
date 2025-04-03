import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:splash/bloc/splash_state.dart';

class SplashContent extends StatelessWidget {
  const SplashContent(this.state, {super.key});

  final SplashState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            if(state.isLoading) const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 30, height: 30, child: CircularProgressIndicator())
                ]
            ),
            if(state.isSuccess) Column(children: [
              Image.memory(
                base64Decode(
                    state.image!
                        .replaceAll("\n", "")
                        .replaceAll(" ", "")
                ),
              ),
              const SizedBox(height: 30),
              Text(
                state.message ?? context.l10n.splashError,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],),
            const Spacer(flex: 1),
          ],
        )
    );
  }
}
