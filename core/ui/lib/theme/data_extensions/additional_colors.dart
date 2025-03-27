import 'package:ui/resources/colors/colors.dart';
import 'package:flutter/material.dart';

///   Example at https://github.com/flutter/flutter/pull/98033

@immutable
class AdditionalColors extends ThemeExtension<AdditionalColors> {
  final Color green;
  final Color onGreen;
  final Color red;
  final Color onRed;
  final Color orange;
  final Color orangeBackground;
  final Color link;

  const AdditionalColors({
    required this.green,
    required this.onGreen,
    required this.red,
    required this.onRed,
    required this.orange,
    required this.orangeBackground,
    required this.link,
  });

  const AdditionalColors.light({
    this.green = CoreUIColors.darkLemonLime,
    this.onGreen = CoreUIColors.white,
    this.red = CoreUIColors.mediumCandyAppleRed,
    this.onRed = CoreUIColors.white,
    this.orange = CoreUIColors.tangerine,
    this.orangeBackground = CoreUIColors.oldLace,
    this.link = CoreUIColors.darkPowderBlue,
  });

  @override
  AdditionalColors copyWith({
    Color? green,
    Color? onGreen,
    Color? red,
    Color? onRed,
    Color? orange,
    Color? orangeBackground,
    Color? link,
  }) {
    return AdditionalColors(
      green: green ?? this.green,
      onGreen: onGreen ?? this.onGreen,
      red: red ?? this.red,
      onRed: onRed ?? this.onRed,
      orange: orange ?? this.orange,
      orangeBackground: orangeBackground ?? this.orangeBackground,
      link: link ?? this.link,
    );
  }

  @override
  AdditionalColors lerp(
    AdditionalColors? other,
    double t,
  ) {
    if (other is! AdditionalColors) {
      return this;
    }
    return const AdditionalColors.light().copyWith(
      green: Color.lerp(green, other.green, t),
      onGreen: Color.lerp(onGreen, other.onGreen, t),
      red: Color.lerp(red, other.red, t),
      onRed: Color.lerp(onRed, other.onRed, t),
      orange: Color.lerp(orange, other.orange, t),
      orangeBackground: Color.lerp(orangeBackground, other.orangeBackground, t),
      link: Color.lerp(link, other.link, t),
    );
  }

  @override
  String toString() =>
      'AdditionalColors(green: $green, onGreen: $onGreen, red: $red, onRed: $onRed, orange: $orange, orangeBackground: $orangeBackground, link: $link)';
}
