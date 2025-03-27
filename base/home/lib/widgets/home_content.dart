import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent(this.goToLogin, this.goToProfile, {super.key});

  final Function() goToLogin;
  final Function() goToProfile;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
