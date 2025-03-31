
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FixedValues {

  static final currency = NumberFormat("\$#,##0.00", "en_US");
  static final shortCurrency = NumberFormat.compactCurrency(locale: "en_US", symbol: "\$", decimalDigits: 2);
  static final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final date = DateFormat('yyyy-MM-dd');

  static RoundedRectangleBorder getCardBorder(int radius){
    return RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius.toDouble())));
  }
}