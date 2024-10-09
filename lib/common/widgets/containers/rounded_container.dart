import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BRoundedContainer extends StatelessWidget {
  const BRoundedContainer(
      {super.key,
      this.child,
      this.size,
      this.padding = const EdgeInsets.all(BSizes.md),
      this.backgroundColor = Colors.transparent,
      this.rounded = Rounded.all});

  final Size? size;
  final EdgeInsets padding;
  final Widget? child;
  final Color backgroundColor;
  final Rounded rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: (size)?.width,
        height: (size)?.height,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BRadiusStyles.radius[rounded],
            color: backgroundColor),
        child: child);
  }
}
