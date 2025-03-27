import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen(this.goToLogin, {super.key});

  final Function() goToLogin;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.signupPageTitle)),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                children: [
                  ElevatedButton(
                    onPressed: goToLogin,
                    child: const Text('Go to Login'),
                  ),
                ],
              )
            )
        )
    );
  }
}
