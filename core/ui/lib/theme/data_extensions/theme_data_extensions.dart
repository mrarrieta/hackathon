import 'package:flutter/material.dart';
import 'additional_colors.dart';

extension ThemeDataX on ThemeData {
  AdditionalColors get additionalColors =>
      extension<AdditionalColors>() ?? const AdditionalColors.light();
}
