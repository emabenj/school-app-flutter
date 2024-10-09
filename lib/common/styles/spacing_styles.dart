import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BSpacingStyles {
  static const paddingWithAppBarHeight = EdgeInsets.only(
      top: BSizes.appBarHeight,
      left: BSizes.defaultSpace,
      bottom: BSizes.defaultSpace,
      right: BSizes.defaultSpace);

  static const paddingWithOutAppBarHeight =
      EdgeInsets.only(bottom: BSizes.md, right: BSizes.md, left: BSizes.md);
      
  static const paddingChat = EdgeInsets.symmetric(horizontal: BSizes.md, vertical: BSizes.xs);
  // EXTRAS CONTAINERS
  static const paddingExtra =
      EdgeInsets.symmetric(vertical: BSizes.sm, horizontal: BSizes.lg);
  // CONTAINER CLICKABLE
  static const paddingCClickable = EdgeInsets.all(BSizes.sm);
}
