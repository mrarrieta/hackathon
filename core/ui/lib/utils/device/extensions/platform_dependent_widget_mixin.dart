import 'package:flutter/material.dart';

import '../platform.dart';

mixin PlatformDependentWidget {
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildIOS(context);
    } else if (Platform.isAndroid) {
      return buildAndroid(context);
    } else if (Platform.isWeb) {
      return buildWeb(context);
    } else {
      throw Exception('OS not supported');
    }
  }

  Widget buildMobile(BuildContext context);

  Widget buildAndroid(BuildContext context) => buildMobile(context);

  Widget buildIOS(BuildContext context) => buildMobile(context);

  Widget buildWeb(BuildContext context);
}
