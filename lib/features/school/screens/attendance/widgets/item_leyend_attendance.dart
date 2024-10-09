import 'package:colegio_bnnm/features/school/models/item_dropdown/attendance_status_model.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/select_attendance.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class ItemLeyendAttendance extends StatelessWidget {
  const ItemLeyendAttendance({super.key, required this.status});
  final AttendanceStatusModel status;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        SelectAttendance(color: status.color, size:BSizes.iconMd),
        Expanded(
          flex: 3,
          child: Text(status.name,
              textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: BColors.white)),
        )
      ]);
  }
}
