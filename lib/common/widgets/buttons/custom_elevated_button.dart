import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BElevatedButton extends StatelessWidget {
  const BElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.height,
      this.style,
      this.buttonColor, this.dark});
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Color? buttonColor;
  final bool? dark;

  @override
  Widget build(BuildContext context) {
    final color = dark ??
        BHelperFunctions.isDarkMode(context) ? Colors.white : BColors.black;
    final textStyle = style ?? Theme.of(context).textTheme.titleMedium!;
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle()
              .copyWith(backgroundColor: MaterialStatePropertyAll(buttonColor)),
          child: Text(text, style: textStyle.apply(color: color))),
    );
  }
}
