import 'package:ui/resources/colors/colors.dart';
import 'package:ui/resources/constants/dimensions.dart';
import 'package:ui/theme/data/color_scheme.dart';
import 'package:ui/theme/data/text_theme.dart';
import 'package:ui/theme/data_extensions/additional_colors.dart';
import 'package:ui/theme/input_decoration_theme.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData.light().copyWith(
  colorScheme: relevantColorSchemeLight,
  textTheme: relevantTextTheme,
  scaffoldBackgroundColor: const Color(0xFFfafafb),
  cardTheme: const CardTheme(
    color: CoreUIColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.d16)),
    ),
    elevation: Dimensions.d4,
    shadowColor: CoreUIColors.cultured,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: CoreUIColors.white,
    selectedItemColor: CoreUIColors.darkPowderBlue,
    unselectedItemColor: CoreUIColors.steelTeal,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: CoreUIColors.darkPowderBlue),
      shape: const StadiumBorder(),
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    const AdditionalColors.light(),
  ],
  inputDecorationTheme: relevantInputDecorationTheme,
);
