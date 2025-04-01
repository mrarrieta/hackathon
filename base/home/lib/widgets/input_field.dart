import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      this.textEditingController,
      this.inputType,
      this.appValidator,
      this.icon,
      {
        this.label,
        this.hint,
        this.style = 0,
        Key? key
      }
      ) : super(key: key);

  final TextEditingController? textEditingController;
  final TextInputType inputType;
  final String? Function(String?)? appValidator;
  final IconData icon;
  final String? hint;
  final String? label;
  final int style;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: style == 0 ? TextAlign.start : TextAlign.center,
      controller: textEditingController,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      validator: appValidator,
    );
  }

}