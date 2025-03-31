import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/dialogs/widgets/dialog_title.dart';
import 'package:ui/dialogs/widgets/network_request_button.dart';

class ConfirmationDialog extends Container{
  ConfirmationDialog({
    required this.title,
    required this.message,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final String title;
  final String message;
  final Function() onClick;

  @override
  Container build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20.0),
              DialogTittle(title, () => Navigator.pop(context)),
              const SizedBox(height: 15.0),
              Container(
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              NetworkRequestButton(
                context.l10n.ok,
                Theme.of(context).primaryColor,
                (context) => onClick.call(),
              ),
              const SizedBox(height: 20.0),
            ],
        ),
    );
  }
}