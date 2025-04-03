import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:signup/data/signup_view_model.dart';
import 'package:signup/widgets/signup_form.dart';
import 'package:signup/data/signup_api.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    required this.signupViewModel,
    required this.goToLogin,
    required this.onSuccess,
    super.key,
  });

  final SignupViewModel signupViewModel;
  final Function() onSuccess;
  final Function() goToLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.signupPageTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignupForm(
            onSignup: ({
              required String name,
              required String password,
              String? lastname,
              String? birthdate,
              String? description,
              String? imageBase64,
            }) {
              debugPrint("Signup: $name, $password, $lastname, $birthdate, $description, image: ${imageBase64 != null ? 'sí' : 'no'}");

              signupViewModel
                  .signup(
                context.l10n,
                SignupResponse(
                  name: name,
                  password: password,
                  lastname: lastname,
                  birthdate: birthdate,
                  description: description,
                  image: imageBase64,
                ),
              )
                  .then((result) {
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l10n.signupSuccessful)),
                  );
                  onSuccess.call();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              }).onError((_, __) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.signupError)),
                );
              });
            },
            goToLogin: goToLogin,
          ),
        ),
      ),
    );
  }
}
