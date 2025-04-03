import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

import '../data/profile_model.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.profileModel,
    required this.goToLogin,
    required this.goToHome,
    super.key,
  });

  final ProfileModel profileModel;
  final Function() goToLogin;
  final Function() goToHome;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.profile)),
        body: SafeArea(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 6),child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileCard(profile: profileModel),
            ],
          ),
        )),
        bottomNavigationBar: AppBottomSheet(
            goToHome: goToHome,
            goToProfile: null,
            goToLogout: goToLogin,
        )
    );
  }
}
