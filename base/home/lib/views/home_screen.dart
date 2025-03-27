import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.goToLogin, this.goToSignup, this.goToProfile, {super.key});

  final Function() goToLogin;
  final Function() goToSignup;
  final Function() goToProfile;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Home Screen", style: TextStyle(fontSize: 20.0)),
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
