import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/school/controllers/attendance/attendance_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/item_leyend_attendance.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FooterAttendance extends StatelessWidget {
  const FooterAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    // Buttons to change assistance status
    final statusList = ItemListController.instance.attendance.value.listAttendanceToSelect();

    final controller = AttendanceController.instance;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //LEYEND
      Container(
          padding: const EdgeInsets.all(BSizes.sm),
          width: BHelperFunctions.screenWidth() * .34,
          decoration: BoxDecoration(
              borderRadius: BRadiusStyles.diagonalBottomLeftMedium,
              color: BHelperFunctions.isDarkMode(context)
                  ? BColors.grey
                  : BColors.greenDark),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(statusList.length,
                  (index) => ItemLeyendAttendance(status: statusList[index])))),
      // BUTTON
      BElevatedButton(
          text: BTexts.saveChangesSalto,
          onPressed: controller.saveChanges,
          width: BHelperFunctions.screenWidth() * .3)
    ]);
  }
}
