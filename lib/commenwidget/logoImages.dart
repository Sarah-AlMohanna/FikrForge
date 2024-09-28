

import 'package:flutter/material.dart';

import '../configuration/images.dart';
import '../configuration/theme.dart';

Hero authLogo() {
  return Hero(
      tag: ImagePath.logoColored,

      child: Image.asset(ImagePath.logoColored ,
        height: size_H(190),
        width: size_W(300),
      ));
}


Hero onBoardingLogo() {
  return Hero(
      tag: ImagePath.logoWhite,

      // child: Image.asset(ImagePath.logoColored,
      child: Image.asset(ImagePath.logoWhite ,
        height: size_H(150),
        width: size_W(300),
      ));
}
