import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
class HeaderAttendance extends StatelessWidget {
  const HeaderAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=BHelperFunctions.isDarkMode(context);
    return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: dark?BColors.greenLight:BColors.redLight,
              borderRadius: BRadiusStyles.diagonalTopLeftLarge
            ),
            padding: const EdgeInsets.symmetric(vertical: BSizes.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(BTexts.attendanceTime, style: Theme.of(context).textTheme.titleMedium!.apply(color: BColors.white)),
              Text(BTexts.attendanceTimeNumber, style: Theme.of(context).textTheme.titleLarge!.apply(color: BColors.black))
            ])
          ),
          const SizedBox(height: BSizes.xs),
          Text(BTexts.attendanceDate, style: Theme.of(context).textTheme.titleLarge)
        ]
      );
  }
}