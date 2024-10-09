import 'package:colegio_bnnm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/device/device_utility.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: BSizes.defaultSpace,
      bottom: BDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
          onPressed: ()=>OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: BHelperFunctions.isDarkMode(context)
                  ? BColors.primary
                  : BColors.black),
          child: const Icon(Icons.arrow_right)),
    );
  }
}
