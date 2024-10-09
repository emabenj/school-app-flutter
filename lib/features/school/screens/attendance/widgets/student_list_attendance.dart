import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/school/controllers/attendance/attendance_controller.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/student_item_attendance.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListAttendance extends StatefulWidget {
  const StudentListAttendance({super.key});

  @override
  State<StudentListAttendance> createState() => _StudentListAttendanceState();
}

class _StudentListAttendanceState extends State<StudentListAttendance> {
  final controller = AttendanceController.instance;
  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        BElevatedButton(
            text: BTexts.attendanceSelectAll,
            onPressed: controller.selectAll,
            width: BHelperFunctions.screenWidth() * .25)
      ]),
      SizedBox(
          height: BHelperFunctions.screenHeight() * .6,
          child: Obx(() => ListView.separated(
              shrinkWrap: true,
              itemCount: controller.models.value.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: BSizes.spaceBtwItems),
              itemBuilder: (context, index) => StudentItemAttendance(
                    model: controller.models.value[index],
                    index: index,
                    pressed: controller.getStatusPressed(index),
                    onTap: !controller.models.value[index].isRetired()
                        ? () => changeStatusPressed(index)
                        : null,
                  )))),
    ]);
  }

  void changeStatusPressed(int index) {
    setState(() {
      controller.changeStatusPressed(index);
    });
  }
}
