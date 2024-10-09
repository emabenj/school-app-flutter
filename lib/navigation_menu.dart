import 'package:colegio_bnnm/data/repositories/messages/messages_repository.dart';
import 'package:colegio_bnnm/data/repositories/personalization/personalization_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final controller = NavigationController.instance;
    // INSTANCE School Repository
    Get.put(SchoolRepository());
    // INSTANCE Personalization Repository
    Get.put(PersonalizationRepository());
    
    if (controller.teacherOrAuthorised()) {
      // INSTANCE Messages Repository only for Teachers and Authoriseds
      Get.put(MessagesRepository());
    }
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
                height: 80,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                backgroundColor: dark ? BColors.dark : BColors.light,
                indicatorColor: dark
                    ? BColors.light.withOpacity(.1)
                    : BColors.dark.withOpacity(.1),
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.home), label: "Inicio"),
                  NavigationDestination(
                      icon: Icon(Icons.wifi_password_sharp), label: "None"),
                ])),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}
