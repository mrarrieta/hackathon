import 'package:flutter/material.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.goToHome,
    required this.goToProfile,
    required this.goToLogout,
  });

  final Function()? goToHome;
  final Function()? goToProfile;
  final Function()? goToLogout;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: goToHome == null ? 0 : goToProfile == null ? 1 : 2,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.house),
          label: context.l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.user),
          label: context.l10n.profile,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.personFromPortal),
          label: context.l10n.logout,
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).cardColor,
      onTap: (int index) {
        if (index == 0) {
          goToHome?.call();
        } else if (index == 1) {
          goToProfile?.call();
        } else if (index == 2) {
          goToLogout?.call();
        }
      },
    );
  }
}
