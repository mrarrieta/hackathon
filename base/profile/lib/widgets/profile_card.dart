import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:profile/data/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final image = profile.imageBase64 != null
        ? Image.memory(base64Decode(profile.imageBase64!), fit: BoxFit.cover)
        : const Icon(Icons.person, size: 100);

    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipOval(
              child: SizedBox(width: 100, height: 100, child: image),
            ),
            const SizedBox(height: 16),
            Text("${profile.name} ${profile.lastname}", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(profile.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text("Año de nacimiento: ${profile.birthYear}", style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
