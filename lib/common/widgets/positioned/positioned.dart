import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';

class BPositioned extends StatelessWidget {
  const BPositioned({super.key, required this.ubi, required this.child, this.size});
  final Positions ubi;
  final Widget child;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ubi == Positions.outTop
        ? Positioned(top: -50, child: child)
        : ubi == Positions.outBottom
            ? Positioned(bottom: -50, child: child)
            : Positioned(top: (size?.height ?? 1) / 3, right: (size?.width ?? 1) /3, child: child);
  }
}
