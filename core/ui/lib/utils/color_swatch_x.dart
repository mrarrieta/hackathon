import 'package:flutter/cupertino.dart';

class ColorSwatchX extends ColorSwatch<int> {
  const ColorSwatchX(
    super.primary,
    super._swatch,
  ) : _sswatch = _swatch;

  final Map<int, Color> _sswatch;

  @override
  Color operator [](int index) {
    final Color? color = super[index];
    if (color != null) return color;
    int? min;
    int? max;
    for (final tone in _sswatch.keys) {
      if (tone < index) {
        min ??= tone;
        if (tone > min) min = tone;
      } else {
        max ??= tone;
        if (tone < max) max = tone;
      }
    }
    return Color.lerp(
      min != null ? _sswatch[min]! : const Color(0xFFFFFFFF),
      max != null ? _sswatch[max]! : const Color(0xFF000000),
      _lerpInt(index, min ?? 0, max ?? 1000, 0, 1),
    )!;
  }

  double _lerpInt(int x, int x1, int x2, int y1, int y2) {
    return y1 + ((x - x1) * ((y2 - y1) / (x2 - x1)));
  }

  static ColorSwatchX? lerp(ColorSwatchX? a, ColorSwatchX? b, double t) {
    final Map<int, Color> swatch;
    if (b == null) {
      if (a == null) {
        return null;
      } else {
        swatch = a._sswatch.map((int key, Color color) =>
            MapEntry<int, Color>(key, Color.lerp(color, null, t)!));
      }
    } else {
      if (a == null) {
        swatch = b._sswatch.map((int key, Color color) =>
            MapEntry<int, Color>(key, Color.lerp(null, color, t)!));
      } else {
        swatch = a._sswatch.map((int key, Color color) =>
            MapEntry<int, Color>(key, Color.lerp(color, b[key], t)!));
      }
    }
    return ColorSwatchX(Color.lerp(a, b, t)!.value, swatch);
  }
}
