import 'dart:ui';

import 'package:colegio_bnnm/common/widgets/positioned/positioned.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BSelectedContainer extends StatelessWidget {
  const BSelectedContainer(
      {super.key,
      this.onTap,
      this.onLongPress,
      required this.child,
      this.childExtra,
      required this.pressed,
      required this.colorOpacity,
      required this.size,
      this.radius = false,
      this.withOpacity = true,
      this.ubi = Positions.center});
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final Widget? childExtra;
  final Positions ubi;
  final bool pressed;
  final Color colorOpacity;
  final bool radius;
  final Size size;
  final bool withOpacity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(children: [
          // child,
          Opacity(
              opacity: pressed && withOpacity ? 0.8 : 1.0,
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: pressed? 5:0, sigmaY:pressed ?5:0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: pressed ? colorOpacity.withOpacity(0.5): Colors.transparent,
                        borderRadius: radius
                            ? BorderRadius.circular(
                                BSizes.borderRadiusContainerMd)
                            : null),
                    // width: size.width,
                    // height: size.height
                    child: child
                  ))),
          childExtra != null
              ? BPositioned(
                  ubi: ubi,
                  size: size,
                  child: Visibility(visible: pressed, child: childExtra!))
              : const SizedBox()
        ]));
  }
}
