import 'package:colegio_bnnm/features/school/controllers/qualifications/qualifications_controller.dart';
import 'package:colegio_bnnm/features/school/screens/qualifications/widgets/qualification_item.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QualificationList extends StatefulWidget {
  const QualificationList({super.key});

  @override
  State<QualificationList> createState() => _QualificationListState();
}

class _QualificationListState extends State<QualificationList> {
  final controller = QualificationsController.instance;

  @override
  void initState() {
    super.initState();
    controller.searchQualifications();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.qualificationFormKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                    controller.getQualificationControllers().length,
                    (index) => Obx(() => QualificationItem(
                        text: "${BTexts.qualification} #${index + 1}:",
                        textController:
                            controller.getQualificationControllers()[index],
                        index: index))) +
                [
                  Obx(
                    () => QualificationItem(
                        text: BTexts.finalQualification,
                        textController: controller.getAverageController(),
                        isAverage: true),
                  )
                ]));
  }
}
