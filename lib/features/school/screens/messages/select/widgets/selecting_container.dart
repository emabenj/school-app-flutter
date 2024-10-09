import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SelectingContainer extends StatelessWidget {
  const SelectingContainer({super.key, required this.onTaps, required this.backgroundColor});
  final List<void Function()> onTaps;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final height =
        BHelperFunctions.screenHeight() * .18 + BSizes.sm + BSizes.iconLg;
    final textStyle = Theme.of(context).textTheme.headlineLarge;
    return Column(
      children: [
        BElevatedButton(
            text: BTexts.messageButtonSend,
            onPressed: onTaps[0],
            height: (height-BSizes.spaceBtwItems)/2 , style: textStyle,
            buttonColor: backgroundColor, dark: true),
        const SizedBox(height: BSizes.spaceBtwItems),
        BElevatedButton(
            text: BTexts.messageButtonSee,
            onPressed: onTaps[1],
            height: (height-BSizes.spaceBtwItems) / 2, style: textStyle,
            buttonColor: backgroundColor, dark: true)
      ],
    );
  }
}
