import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

import '../data/profile_model.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.goToLogin, this.goToHome, {super.key});

  final Function() goToLogin;
  final Function() goToHome;


  @override
  Widget build(BuildContext context) {

    final dummyProfile = ProfileModel(
      name: "Paco",
      lastname: "Gomez",
      description: "Amante de la tecnología y explorador del tiempo.",
      birthYear: "1997",
      imageBase64: null,
    );

    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.profile)),
        body: SafeArea(
          child: ProfileCard(profile: dummyProfile),
        ),
        bottomNavigationBar: AppBottomSheet(
            goToHome: goToHome,
            goToProfile: null,
            goToLogout: goToLogin,
        )
    );
  }
}
