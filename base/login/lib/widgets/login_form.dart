import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_view_model.dart';
import 'package:ui/widgets/custom_button.dart';
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
          CustomInput(
            label: context.l10n.email,
            onSaved: (value) => widget.loginViewModel.name = value ?? '',
            validator: (value) => value!.isEmpty ? required : null,
          ),
          const SizedBox(height: 16),
          CustomInput(
            label: context.l10n.password,
            obscureText: true,
            onSaved: (value) => widget.loginViewModel.password = value ?? '',
            validator: (value) => value!.isEmpty ? required : null,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(text: context.l10n.login, onPressed: _submit),
              const SizedBox(width: 20),
              CustomButton(text: context.l10n.signupPageTitle, onPressed: widget.goToSignup),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(text: "bypass login", onPressed: widget.onSuccess),
        ],
      ),
    );
  }
}
