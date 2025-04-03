import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:signup/widgets/signup_form.dart';
import 'package:signup/data/signup_api.dart';
import 'package:signup/bloc/signup_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    required this.signupClient,
    required this.goToLogin,
    required this.onSuccess,
    super.key,
  });

  final SignupClient signupClient;
  final Function() onSuccess;
  final Function() goToLogin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(signupClient, context.l10n),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupResponse != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.signupSuccessful)),
            );
            onSuccess.call();
          } else if (state.signupError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.signupError!)),
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text(context.l10n.signupPageTitle)),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
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
                      context.read<SignupCubit>().signup(
                        SignupResponse(
                          name: name,
                          password: password,
                          lastname: lastname,
                          birthdate: birthdate,
                          description: description,
                          image: imageBase64,
                        ),
                      );
                    },
                    goToLogin: goToLogin,
                  ),
                ),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
