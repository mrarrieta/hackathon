import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/bloc/LoginState.dart';
import 'package:login/data/login_api.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    required this.loginClient,
    required this.goToSignup,
    required this.onSuccess,
    super.key
  });

  final LoginClient loginClient;
  final Function() onSuccess;
  final Function() goToSignup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(loginClient, context.l10n),
      child: BlocConsumer<LoginCubit,LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(context.l10n.loginSuccessful)));
              onSuccess.call();
            } else if (state.loginError != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.loginError!)));
            }
          },
          builder: (context,state) => Scaffold(
            appBar: AppBar(title: Text(context.l10n.loginPageTitle)),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LoginForm(
                      skipLogin: onSuccess,
                      goToSignup: goToSignup,
                    )
                )
            ),
          )
      ),
    );
  }
}
