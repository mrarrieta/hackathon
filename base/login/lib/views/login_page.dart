import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_view_model.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this.loginViewModel, this.onSuccess, {super.key});

  final LoginViewModel loginViewModel;
  final Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.loginPageTitle)),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(loginViewModel,onSuccess),
          )
      ),
    );
  }
}
