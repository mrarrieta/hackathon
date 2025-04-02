import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_view_model.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';
import 'custom_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.loginViewModel,
    required this.goToSignup,
    required this.onSuccess,
    super.key
  });

  final LoginViewModel loginViewModel;
  final Function() onSuccess;
  final Function() goToSignup;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final result = await widget.loginViewModel.login(context.l10n);

      if (result == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.loginSuccessful)));
        widget.onSuccess.call();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    var required = context.l10n.required;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: CustomInput(
            label: context.l10n.email,
            onSaved: (value) => widget.loginViewModel.name = value ?? '',
            validator: (value) => value!.isEmpty ? required : null,
          )),
          const SizedBox(height: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: CustomInput(
            label: context.l10n.password,
            obscureText: true,
            onSaved: (value) => widget.loginViewModel.password = value ?? '',
            validator: (value) => value!.isEmpty ? required : null,
          )),
          const SizedBox(height: 30),
          DialogButton(context.l10n.login, Theme.of(context).primaryColor, (_) => _submit.call()),
          const SizedBox(height: 15),
          DialogButton(context.l10n.signupPageTitle, Theme.of(context).primaryColor, (_) => widget.goToSignup.call()),
          const SizedBox(height: 15),
          DialogButton("bypass login", Theme.of(context).primaryColor, (_) => widget.onSuccess.call()),
        ],
      ),
    );
  }
}
