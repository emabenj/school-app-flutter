import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/new.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsBoardHome extends StatefulWidget {
  const NewsBoardHome({super.key});

  @override
  State<NewsBoardHome> createState() => _NewsBoardHomeState();
}

class _NewsBoardHomeState extends State<NewsBoardHome> {
  final controller = Get.put(NewsController());
  final navController = NavigationController.instance;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // GET News
    final items = await ItemListController.instance.getNews();
    items.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

    controller.setModels(items);
    controller.forA.value = navController.isAdmin();
    if (navController.teacherOrAuthorised()) {
      // INSTANCE SelectController
      final selectController = Get.put(SelectController());
      await ItemListController.instance.getAttendanceStatus();
      await ItemListController.instance.getHomeworkStatus();
      // CARGAR aulas o estudiantes (solo Apoderado o Docente)
      await selectController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Padding(
        padding: const EdgeInsets.all(0),
        child: SizedBox(
            height: BHelperFunctions.screenHeight() * .73,
            child: Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.news.length,
                  itemBuilder: (context, i) => NewForHome(
                      model: controller.news[i],
                      onTapCrudButtons: () => _onTapCrudActions(i),
                      index: i),
                  separatorBuilder: (context, index) => Divider(
                      color: dark ? BColors.light : BColors.black, height: 1)),
            )));
  }

  void _onTapCrudActions(int index) {
    if (controller.isRemoving()) {
      setState(() {
        controller.setModel(index, forDelet: true);
        controller.removeModel(index);
      });
    } else {
      controller.setModel(index);
    }
  }
}
