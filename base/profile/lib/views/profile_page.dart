import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.goToLogin, this.goToHome, {super.key});

  final Function() goToLogin;
  final Function() goToHome;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.profile)),
        body: const SafeArea(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [],
                )
            ),
        ),
        bottomNavigationBar: AppBottomSheet(
            goToHome: goToHome,
            goToProfile: null,
            goToLogout: goToLogin,
        )
    );
  }
}
