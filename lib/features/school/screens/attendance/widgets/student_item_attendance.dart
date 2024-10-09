import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/attendance/attendance_model.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/item_attendance.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StudentItemAttendance extends StatelessWidget {
  const StudentItemAttendance(
      {super.key,
      required this.model,
      required this.index,
      required this.pressed,
      required this.onTap});
  final AttendanceModel model;
  final bool pressed;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // IMG
    final sizeImg = BHelperFunctions.screenHeight() * .1;
    // NAME
    final widthName = sizeImg * 1.2;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Row(
          children: [
            Image.asset(model.genderImage, width: sizeImg, fit: BoxFit.cover),
            SizedBox(
                width: widthName,
                child: Column(
                  children: [Text(model.name), Text(model.lastname)],
                ))
          ],
        )
      ]),
      ItemAttendance(
        status:
            ItemListController.instance.attendance.value.mapper.getModelById(model.status),
        pressed: pressed,
        indexItem: index,
        onTap: onTap,
      )
    ]);
  }
}
