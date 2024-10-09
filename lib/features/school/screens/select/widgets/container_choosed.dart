import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ContainerChoosed extends StatelessWidget {
  const ContainerChoosed({super.key, required this.model, this.height = 75});
  final SelectModel model;
  final double height;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final bg = dark ? BColors.black : BColors.grey;

    final textColors = [BColors.white, BColors.light];
    final stateTextColor = model.stateUsers.contains("No")
        ? BColors.redLight
        : dark
            ? BColors.greenLight
            : BColors.greenLight;
    return BRoundedContainer(
        padding: BSpacingStyles.paddingCClickable,
        backgroundColor: bg,
        size: Size(double.infinity, height),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // IMG CIRCULAR
          Container(
              width: height - BSizes.sm * 2,
              height: height - BSizes.sm * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height - BSizes.sm * 2),
                  color: Colors.red)),
          const SizedBox(width: BSizes.spaceBtwItems),
          SizedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // TITLE
                  Text(model.title,
                                  softWrap: false,
                                  maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: textColors[0])),
                  //SUBTITLE
                  Text(model.subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: textColors[1])),
                ]),
                //STATE USERS
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(model.stateUsers,
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: stateTextColor)),
                ])
              ]))
        ]));
  }
}
