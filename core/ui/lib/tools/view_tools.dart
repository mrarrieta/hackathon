import 'package:flutter/cupertino.dart';

class ViewTools {

  static double getPercentageWidth(BuildContext context, double percentage) {
    return (MediaQuery.of(context)
        .size
        .width * percentage) / 100;
  }

  static double getPercentageHeight(BuildContext context, double percentage) {
    return (MediaQuery.of(context)
        .size
        .height * percentage) / 100;
  }
}