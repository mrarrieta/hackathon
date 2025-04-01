import 'package:flutter/material.dart';
import 'package:ui/tools/fixed_values.dart';
import 'package:ui/tools/view_tools.dart';

class RecordSeparator extends StatelessWidget {
  const RecordSeparator(this.text, this.color, this.textColor, {Key? key}) : super(key: key);

  final String? text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            shape: FixedValues.getCardBorder(10),
            shadowColor: Colors.black,
            elevation: 5,
            color: color,
            margin: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
            child: Container(
              width: ViewTools.getPercentageHeight(context, 100),
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(text!, textAlign: TextAlign.center, textScaleFactor: 1.1, style: TextStyle(color: textColor, fontWeight: FontWeight.bold),),
            )
        )
    );
  }

}