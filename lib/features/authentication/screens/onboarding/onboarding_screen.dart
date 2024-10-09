import 'package:colegio_bnnm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:colegio_bnnm/features/authentication/screens/onboarding/widgets/on_boarding_dot_navigation.dart';
import 'package:colegio_bnnm/features/authentication/screens/onboarding/widgets/on_boarding_next_button.dart';
import 'package:colegio_bnnm/features/authentication/screens/onboarding/widgets/on_boarding_page.dart';
import 'package:colegio_bnnm/features/authentication/screens/onboarding/widgets/on_boarding_skip.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
        body: Stack(children: [
      // HORIZONTAL SCROLLABLE PAGES
      PageView(
        controller: controller.pageController,
        onPageChanged: controller.updatePageIndicator,
        children: const [
          OnBoardingPage(
              image: BImages.onBoardingImage1,
              title: BTexts.onBoardingTitle1,
              subTitle: BTexts.onBoardingSubTitle1),
          OnBoardingPage(
              image: BImages.onBoardingImage2,
              title: BTexts.onBoardingTitle2,
              subTitle: BTexts.onBoardingSubTitle2),
          OnBoardingPage(
              image: BImages.onBoardingImage3,
              title: BTexts.onBoardingTitle3,
              subTitle: BTexts.onBoardingSubTitle3),
        ],
      ),
      // SKIP BUTTON
      const OnBoardingSkip(),
      // DOT NAVIGATION SMOOTHPAGEINDICATOR
      const OnBoardingDotNavigation(),
      // CIRCULAR BUTTON
      const OnBoardingNextButton()
    ]));
  }
}
