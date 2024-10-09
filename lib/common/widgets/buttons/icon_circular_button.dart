import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class IconCircularButton extends StatelessWidget {
  const IconCircularButton(
      {super.key,
      required this.onTap,
      required this.size,
      required this.img,
      this.enabled = true,
      this.backgroundColor});

  final void Function() onTap;
  final Size size;
  final String img;
  final bool enabled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final sizeBackground = size.width * 1.5;
    final imgWidget = SizedBox(
      width: size.width,
      height: size.height,
      child: Image.asset(img,
          fit: BoxFit.fill,
          color: enabled ? null : BColors.greenDark.withOpacity(.99),
          colorBlendMode: BlendMode.modulate),
    );
    final withBackground = backgroundColor != null;
    final radiusBtn = (withBackground ? sizeBackground : size.width) / 2;
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBtn), color: backgroundColor);

    return InkWell(
        borderRadius: BorderRadius.circular(radiusBtn),
        onTap: enabled?onTap:null,
        splashColor: Colors.black26,
        child: Ink(
            child: backgroundColor != null
                ? Container(
                    width: sizeBackground,
                    height: sizeBackground,
                    padding: const EdgeInsets.all(BSizes.sm),
                    decoration: decoration,
                    child: imgWidget,
                  )
                : imgWidget));
  }
}
