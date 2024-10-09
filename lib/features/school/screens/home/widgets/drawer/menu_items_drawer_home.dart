import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/personalization/screens/update_details/update_details_screen.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/screens/new/new_screen.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/register_account_screen.dart';
import 'package:colegio_bnnm/features/school/screens/select/select_screen.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemsDrawerHome extends StatelessWidget {
  const MenuItemsDrawerHome({super.key, required this.role});
  final Roles role;

  @override
  Widget build(BuildContext context) {
    final labels = BTexts.drawerActions(role);
    List<Widget> items = List.generate(labels.length,
        (index) => MenuItemDrawerHome(text: labels[index], role: role));
    items.insert(items.length, const Divider());
    items.insert(items.length, MenuItemDrawerHome(text: "Salir", role: role));
    return Padding(
      padding: const EdgeInsets.all(BSizes.defaultSpace),
      child: Container(
          padding: const EdgeInsets.only(top: 15),
          height: BHelperFunctions.screenHeight() * .61,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: items)),
    );
  }
}

class MenuItemDrawerHome extends StatelessWidget {
  final String text;
  final Roles role;
  const MenuItemDrawerHome({super.key, required this.text, required this.role});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Material(
        color: dark ? BColors.dark : BColors.light,
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
              // FOR ADMIN ---------------------------------------------------------------------------
              if (text == "Actualizar") {
                Get.to(() => const UpdateDetailsScreen());
              } else if (text.contains("Registrar")) {
                String selected =
                    text.toLowerCase().replaceAll("registrar ", "");
                selected = selected == "apoderado"
                    ? Roles.authorised.name
                    : Roles.teacher.name;
                Get.to(() => RegisterAccountScreen(type: selected));
              } else if (text == "Publicar noticia") {
                final controller = Get.put(NewsController());
                controller.setInsert();
                Get.to(() => const NewsControlScreen());
                // FOR TEACHERS ---------------------------------------------------------------------------
              } else if (text == "Perfil") {
                Get.to(() => const UpdateDetailsScreen());
              } else if (BTexts.listTeacher.contains(text)) {
                final states = [
                  StatusSelection.selAttendance,
                  StatusSelection.selQualifications,
                  StatusSelection.selHomework,
                  StatusSelection.messagesToParents
                ];
                final controller = SelectController.instance;
                controller.setState(states[BTexts.listTeacher.indexOf(text)], fromDrawer: true);
                Get.to(() => SelectScreen(forT: role == Roles.teacher));
                // FOR PARENTS ---------------------------------------------------------------------------
              } else if (BTexts.listAuthorised.contains(text)) {
                if (text == BTexts.listAuthorised[0]) {
                  final controller =
                      SelectController.instance; //Get.put(SelectController());
                  controller.setState(StatusSelection.messagesToTeachers, fromDrawer: true);
                  Get.to(() => SelectScreen(forT: role == Roles.teacher));
                } // FOR ALL
              } else if (text == "Salir") {
                AuthenticationRepository.instance.loginOut();
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(BSizes.sm),
                child: Row(children: [
                  const Icon(Icons.home),
                  const SizedBox(width: BSizes.spaceBtwItems),
                  Expanded(child: Text(text))
                ]))));
  }
}
