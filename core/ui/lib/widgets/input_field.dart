import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      this.textEditingController,
      this.inputType,
      this.appValidator,
      {
        this.label,
        this.hint,
        this.style = 0,
        this.obscureText = false,
        this.icon,
        Key? key
      }
      ) : super(key: key);

  final TextEditingController? textEditingController;
  final TextInputType inputType;
  final String? Function(String?)? appValidator;
  final IconData? icon;
  final String? hint;
  final String? label;
  final int style;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: style == 0 ? TextAlign.start : TextAlign.center,
      controller: textEditingController,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      validator: appValidator,
      obscureText: obscureText,
      decoration: getDecoration(context),
    );
  }

  getDecoration(BuildContext context) {
    if (icon != null) {
      return InputDecoration(
        labelText: label,
        icon: Icon(icon, color: Theme
            .of(context)
            .primaryColor),
      );
    } else {
      return InputDecoration(
        labelText: label,
      );
    }
  }

}