import 'package:flutter/material.dart';
import 'package:home/widgets/home_content.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.goToLogin, this.goToSignup, this.goToProfile, {super.key});

  final Function() goToLogin;
  final Function() goToSignup;
  final Function() goToProfile;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.homePageTitle)),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: HomeContent(goToLogin, goToSignup, goToProfile)
            )
        ),
      bottomSheet: AppBottomSheet(
        goToHome: () {},
        goToProfile: goToProfile,
        goToLogout: goToLogin,
      ),
    );
  }
}
