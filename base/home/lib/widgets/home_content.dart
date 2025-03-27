import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent(this.goToLogin, this.goToSignup, this.goToProfile, {super.key});

  final Function() goToLogin;
  final Function() goToSignup;
  final Function() goToProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: goToSignup,
          child: const Text('Go to Signup'),
        ),
      ],
    );
  }
}
