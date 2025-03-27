import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static final _baseStyle = Typography.blackMountainView.bodyMedium!;
  static final buttonSmall = _baseStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static final buttonNormal = _baseStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static final buttonNormal2 = _baseStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static final body1 = _baseStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static final body2 = _baseStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static final body3 = _baseStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static final titleH4 = _baseStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
}
