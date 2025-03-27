import 'package:ui/utils/color_swatch_x.dart';
import 'package:flutter/cupertino.dart';

mixin AppColors {
  static const white = Color(0xFFFFFFFF);
  static const businessGreen = Color(0xFF78BE20);
  static const businessCian = Color(0xFF00A3E0);
  static const businessOrange = Color(0xFFE3E829);
  static const blue = ColorSwatchX(
    0xFF0033A0,
    <int, Color>{
      100: Color(0xFFE0EAFF),
      200: Color(0xFFD1E0FF),
      500: Color(0xFF9EBDFF),
      600: Color(0xFF0D54FF),
      700: Color(0xFF0033A0),
      800: Color(0xFF02226B),
    },
  );
  static const aqua = ColorSwatchX(
    0xFF00AEC7,
    <int, Color>{
      100: Color(0xFFDCF3F9),
      600: Color(0xFF4EC3E0),
      700: Color(0xFF00AEC7),
      800: Color(0xFF1E8DA9),
    },
  );
  static const midYellow = ColorSwatchX(
    0xFFFFE946,
    <int, Color>{
      100: Color(0xFFFFF5AD),
      500: Color(0xFFFFE946),
      800: Color(0xFFFDDA25),
      900: Color(0xFFFFCD00),
    },
  );
  static const yellow = ColorSwatchX(
    0xFFE3E829,
    <int, Color>{
      100: Color(0xFFFFF5AD),
      500: Color(0xFFFFF5AD),
      800: Color(0xFFFFF5AD),
      900: Color(0xFFFFF5AD),
    },
  );
  static const neutral = ColorSwatchX(
    0xFF53565A,
    <int, Color>{
      100: Color(0xFFFCFCFC),
      400: Color(0xFFDDDDDE),
      600: Color(0xFF95989D),
      700: Color(0xFF73777D),
      800: Color(0xFF53565A),
      900: Color(0xFF3B3D40),
    },
  );
  static const error = ColorSwatchX(
    0xFFF9423A,
    <int, Color>{
      50: Color(0xFFFEECEB),
      400: Color(0xFFFF585D),
      500: Color(0xFFF9423A),
      700: Color(0xFFE4002B),
    },
  );
  static const success = ColorSwatchX(
    0xFF07BB20,
    <int, Color>{
      50: Color(0xFFD8F7DC),
      400: Color(0xFF38C84B),
      500: Color(0xFF07BB20),
      700: Color(0xFF067014),
    },
  );
  static const warning = ColorSwatchX(
    0xFFFF9A41,
    <int, Color>{
      50: Color(0xFFFFF5EC),
      400: Color(0xFFFFAE67),
      500: Color(0xFFFF9A41),
      700: Color(0xFFA36126),
    },
  );
}
