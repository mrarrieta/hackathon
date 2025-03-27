import 'package:ui/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

InputDecorationTheme relevantInputDecorationTheme = InputDecorationTheme(
  fillColor: Colors.white,
  filled: true,
  floatingLabelStyle: const TextStyle(
    color: AppColors.blue,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  labelStyle: TextStyle(
    color: AppColors.neutral[700],
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    color: AppColors.neutral[700],
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  helperStyle: TextStyle(
    color: AppColors.neutral[800],
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: AppColors.neutral[700],
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: AppColors.neutral[700],
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: AppColors.neutral[100],
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: AppColors.blue,
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      color: AppColors.error,
    ),
  ),
);
