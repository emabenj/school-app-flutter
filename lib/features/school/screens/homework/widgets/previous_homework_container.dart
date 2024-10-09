import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';
import 'package:colegio_bnnm/features/school/screens/homework/widgets/details_homework.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousHomeworkContainer extends StatefulWidget {
  const PreviousHomeworkContainer({super.key});

  @override
  State<PreviousHomeworkContainer> createState() =>
      _PreviousHomeworkContainerState();
}

class _PreviousHomeworkContainerState extends State<PreviousHomeworkContainer> {
  final controller = HomeworkController.instance;
  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.models.length,
        separatorBuilder: (context, index) => const SizedBox(height: BSizes.sm),
        itemBuilder: (context, index) {
          return DetailsHomework(
            model: controller.models[index].details(),
            index: index,
            pressed: controller.isPressedList[index],
            onTap: () => changeState(index),
          );
        }));
  }

  void changeState(int index) {
    setState(() {
      controller.changeStatePressed(index);
    });
  }
}
