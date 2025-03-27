import 'package:flutter/foundation.dart';

/// Check if device is Apple or not, to run with the appropriate theme
class OS {
  static get isCupertino =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  static get isMaterial => !isCupertino;
}
