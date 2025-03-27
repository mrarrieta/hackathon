import 'package:flutter/material.dart';

abstract class WidgetStatePropertyX {
  static WidgetStateProperty<T> resolveWith<T>({
    required T defaultValue,
    required Map<WidgetState, T> propertyByState,
  }) {
    return WidgetStateProperty.resolveWith<T>((states) {
      if (states.isEmpty) return defaultValue;
      if (states.length == 1) {
        return propertyByState[states.first] ?? defaultValue;
      }
      for (final entry in propertyByState.entries) {
        if (states.contains(entry.key)) return entry.value;
      }
      return defaultValue;
    });
  }

  static WidgetStateProperty<TextStyle?> mergeTextStyleProps(
    WidgetStateProperty<TextStyle?> prop1,
    WidgetStateProperty<TextStyle?> prop2,
  ) {
    return WidgetStateProperty.resolveWith<TextStyle?>((states) {
      final value1 = prop1.resolve(states);
      final value2 = prop2.resolve(states);
      return value1?.merge(value2);
    });
  }
}
