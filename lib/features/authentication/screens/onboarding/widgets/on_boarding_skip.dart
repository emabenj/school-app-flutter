import 'package:colegio_bnnm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: BDeviceUtils.getAppBarHeight(),
        right: BSizes.defaultSpace,
        child: TextButton(
            onPressed: () => OnBoardingController.instance.skipPage(),
            child: const Text("Skip")));
  }
}
