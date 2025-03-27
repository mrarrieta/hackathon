import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen(this.goToLogin, this.goToSignup, this.goToHome, {super.key});

  final Function() goToLogin;
  final Function() goToSignup;
  final Function() goToHome;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Profile Screen", style: TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToLogin,
                    child: const Text('Go to Login'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToSignup,
                    child: const Text('Go to Signup'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToHome,
                    child: const Text('Go to Home'),
                  ),
                ],
              )
            )
        )
    );
  }
}
