import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.goToLogin, this.goToSignup, this.goToHome, {super.key});

  final Function() goToLogin;
  final Function() goToSignup;
  final Function() goToHome;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.profile)),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: goToSignup,
                      child: const Text('Go to Signup'),
                    ),
                  ],
                )
            ),
        ),
        bottomSheet: AppBottomSheet(
            goToHome: goToHome,
            goToProfile: () {},
            goToLogout: goToLogin,
        )
    );
  }
}
