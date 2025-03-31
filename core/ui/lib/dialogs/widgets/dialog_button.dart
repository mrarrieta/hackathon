import 'package:flutter/material.dart';
import 'package:ui/tools/fixed_values.dart';

class DialogButton extends StatelessWidget {
  const DialogButton(this.text, this.color, this.onClick, {this.fontSize = 20, Key? key})
      : super(key: key);

  final String? text;
  final Color color;
  final Function(BuildContext) onClick;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: fontSize == 18 ? 10 : 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: FixedValues.getCardBorder(10),
              shadowColor: Colors.white,
              elevation: 10,
              minimumSize: Size.fromHeight(fontSize+17),
          ),
          child: Text(text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: fontSize)),
          onPressed: () => onClick.call(context),
        )
    );
  }
}
