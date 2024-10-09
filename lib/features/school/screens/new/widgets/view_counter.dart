import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class ViewCounter extends StatelessWidget {
  const ViewCounter(
      {super.key,
      required this.style,
      required this.views,
      required this.borderColor,
      required this.backgroundColor});
  final TextStyle style;
  final String views;
  final Color borderColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: BSizes.containerViewCounter,
        padding: const EdgeInsets.all(BSizes.xs),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BRadiusStyles.chatRightMedium),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Icon(Icons.visibility),
          Text(views, style: style)
        ]));
  }
}
