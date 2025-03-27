import 'package:flutter/material.dart';

import '../os.dart';

mixin OSDependentWidget {
  Widget build(BuildContext context) {
    if (OS.isCupertino) {
      return buildCupertino(context);
    } else if (OS.isMaterial) {
      return buildMaterial(context);
    } else {
      throw Exception('OS not supported');
    }
  }

  Widget buildCupertino(BuildContext context);

  Widget buildMaterial(BuildContext context);
}
