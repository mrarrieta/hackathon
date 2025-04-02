import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_view_model.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    required this.loginViewModel,
    required this.goToSignup,
    required this.onSuccess,
    super.key
  });

  final LoginViewModel loginViewModel;
  final Function() onSuccess;
  final Function() goToSignup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.loginPageTitle)),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(
                onLogin: (user, pass) {
                  debugPrint("Login: $user, $pass");
                  loginViewModel.login(context.l10n, user, pass).then((result) {
                    if (result == null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(
                          content: Text(context.l10n.loginSuccessful)));
                      onSuccess.call();
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(result)));
                    }
                  });
                },
                skipLogin: onSuccess,
                goToSignup: goToSignup,
            )
          )
      ),
    );
  }
}
