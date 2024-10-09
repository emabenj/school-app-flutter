import 'package:flutter/material.dart';

class BSizes {
  // PADDING AND MARGIN 5
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // ICON 4
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 45.0;
  static const double iconButtonMd = 50.0;
  static const double iconButtonLg = 60.0;
  static const double iconContainer = 75.0;

  // FONT 3
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  // BUTTON
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;

  // APPBAR 1
  static const double appBarHeight = 56.0;

  // IMAGE 1
  static const double imageThumbSize = 80.0;

  // DEFAULT SPACING BETWEEN SECTIONS 3
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtnSections = 32.0;

  // BORDER RADIUS 5
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusContainerLg = 50.0;
  static const double borderRadiusContainerMd = 20.0;

  // DIVIDER HEIGHT 1
  static const double dividerHeight = 1.0;

  // CONTAINER
  static const double containerViewCounter = 33.0;
  // EXTRA CONTAINER
  static Size getSizeContainer(int total,
      {double pv = 8,
      double ph = 24,
      bool? isMd,
      double icon = 12,
      double space = 8,
      bool row = true}) {
    // ph: BSizes.sm,
    // pv: 0,
    final spaceSize = isMd != null
        ? isMd
            ? sm
            : md
        : space;
    final iconSize = isMd != null
        ? isMd
            ? iconButtonMd
            : iconButtonLg
        : icon;
    final size = Size(
        ph * 2 + iconSize * total + (total - 1) * spaceSize, pv * 2 + iconSize);
    return row ? size : Size(size.height, size.width);
  }

  // PRODUCT ITEM DIMENTIONS 3 CHANGE
  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;
  static const double productItemHeight = 160.0;

  // INPUT FIELD 2
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // CARD 5
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 100.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  // IMAGE CAROUSEL HEIGHT 1
  static const double imageGender = 100.0;
  // static const double imageCarouselHeight = 200.0;

  // LOADING INDICATOR 1
  static const double loadingIndicatorSize = 36.0;

  // GRID VIEW SPACING 1
  static const double gridViewSpacing = 16.0;

  // SIZE Circular Icon Attendance
  static const double iconAttendance = 35.0;
}
