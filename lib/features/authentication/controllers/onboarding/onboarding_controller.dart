import "package:colegio_bnnm/features/authentication/screens/login/login_screen.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // VARS
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // UPDATE CURRENT INDEX WHEN PAGE SCROLL
  void updatePageIndicator(index) => currentPageIndex.value = index;
  // JUMP TO THE SPECIFIC DOT SELECTED ROW
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // UPDATE CURRENT INDEX AND JUMPT TO NEXT PAGE
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write("isFirstTime", false);
      Get.to(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //UPDATE CURRENT INDEX AND JUMPT TO THE PAGE
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
