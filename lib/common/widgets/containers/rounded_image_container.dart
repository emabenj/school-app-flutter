import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:flutter/material.dart';

class BorderedContainerImage extends StatelessWidget {
  const BorderedContainerImage({super.key, required this.img, this.radius = BRadiusStyles.diagonalTopLeftLarge});
  final Widget img;
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: radius, child: img);
  }
}
