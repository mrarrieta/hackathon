import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen(this.goToLogin, this.goToHome, this.goToProfile, {super.key});

  final Function() goToLogin;
  final Function() goToHome;
  final Function() goToProfile;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Signup Screen", style: TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToLogin,
                    child: const Text('Go to Login'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToHome,
                    child: const Text('Go to Home'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToProfile,
                    child: const Text('Go to Profile'),
                  ),
                ],
              )
            )
        )
    );
  }
}
