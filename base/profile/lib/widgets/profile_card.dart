import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:profile/data/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final yearOrBirth = DateTime.parse(profile.birthDate).year;
    final image = profile.imageBase64 != null
        ? getImage(context)
        : Icon(FontAwesomeIcons.circleUser, color: Theme.of(context).primaryColor, size: 150);

    return Card(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          const Spacer(flex: 1), // Add a spacer to push the image to the left
          Column(
            children: [
              const SizedBox(height: 20), // Add a spacer to push the image down
              ClipOval(
                child: SizedBox(width: 150, height: 150, child: image),
              ),
              const SizedBox(height: 20),
              Text(
                  "${profile.name} ${profile.lastname}",
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              Text(
                  profile.description,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              Text(
                  "${context.l10n.yearOfBirth} $yearOrBirth",
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 20), //
            ],
          ),
          const Spacer(flex: 1),
        ],),
      ),
    );
  }

  Widget getImage(BuildContext context) {
    try {
      return Image.memory(base64Decode(profile.imageBase64!), fit: BoxFit.cover, height: 150, width: 150);
    } on Exception catch (_, error) {
      debugPrintStack(stackTrace: error);
      return const Icon(FontAwesomeIcons.circleUser, color: Colors.white, size: 150);
    }
  }
}
