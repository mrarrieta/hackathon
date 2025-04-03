import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';
import 'package:ui/widgets/input_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    required this.onSignup,
    required this.goToLogin,
    super.key,
  });

  final Function({
  required String name,
  required String password,
  required String? lastname,
  required String? birthdate,
  required String? description,
  required String? imageBase64,
  }) onSignup;

  final Function() goToLogin;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final descController = TextEditingController();
  final lastnameController = TextEditingController();
  DateTime? selectedDate;
  String? imageBase64;

  final picker = ImagePicker();

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        imageBase64 = base64Encode(bytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final required = context.l10n.required;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(FontAwesomeIcons.userPlus, size: 150, color: Theme.of(context).primaryColor),
            const SizedBox(height: 30),

            // Nombre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                nameController,
                TextInputType.text,
                    (value) => value!.isEmpty ? required : null,
                label: context.l10n.name,
              ),
            ),
            const SizedBox(height: 10),

            // Apellido
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                lastnameController,
                TextInputType.text,
                    (_) => null,
                label: context.l10n.lastname ?? "Apellido",
              ),
            ),
            const SizedBox(height: 10),

            // Fecha de nacimiento
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                title: Text(selectedDate == null
                    ? context.l10n.date
                    : DateFormat.yMMMMd('es').format(selectedDate!)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
            ),
            const SizedBox(height: 10),

            // Contraseña
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                passController,
                TextInputType.text,
                    (value) => value!.isEmpty ? required : null,
                obscureText: true,
                label: context.l10n.password,
              ),
            ),
            const SizedBox(height: 10),

            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                descController,
                TextInputType.text,
                    (_) => null,
                label: context.l10n.description,
              ),
            ),
            const SizedBox(height: 10),

            // Imagen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: Text(context.l10n.selectImage ?? "Seleccionar imagen"),
                  ),
                  const SizedBox(width: 10),
                  if (imageBase64 != null)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 30),

            DialogButton(context.l10n.signup, Theme.of(context).primaryColor, (_) {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSignup(
                  name: nameController.text,
                  password: passController.text,
                  lastname: lastnameController.text,
                  birthdate: selectedDate?.toIso8601String(),
                  description: descController.text,
                  imageBase64: imageBase64,
                );
              }
            }),
            const SizedBox(height: 15),
            DialogButton(context.l10n.backToLogin, Theme.of(context).primaryColor, (_) => widget.goToLogin.call()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
