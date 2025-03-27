import 'package:flutter/foundation.dart';

/// Check if device is Mobile or Web to run the correct proportions
class Platform {
  static get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  static get isMobile => isIOS || isAndroid;

  static get isWeb => !isMobile;
}
