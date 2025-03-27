import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackBar = SnackBar(content: Text(message));

  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(snackBar);
}
