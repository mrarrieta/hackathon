import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_images.dart';
import 'constants/dimensions.dart';

class AppAsset {
  const AppAsset();

  static Widget logo() {
    return Image(
      image: AssetImage(
        AppImages.logoJpg.path,
      ),
      height: Dimensions.d120,
      width: Dimensions.d120,
    );
  }
}