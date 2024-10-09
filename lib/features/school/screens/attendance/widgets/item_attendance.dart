import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/controllers/attendance/attendance_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/attendance_status_model.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/select_attendance.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemAttendance extends StatelessWidget {
  const ItemAttendance(
      {super.key,
      required this.status,
      required this.pressed,
      required this.indexItem,
      required this.onTap});
  final AttendanceStatusModel status;
  final bool pressed;
  final int indexItem;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    // BUTTONS CONTAINER
    const sizeButton = BSizes.iconLg;
    final sizeGroupContainer = BSizes.getSizeContainer(3,
        ph: BSizes.sm, pv: BSizes.sm, space: BSizes.sm, icon: sizeButton);
    final sizeSingleContainer = BSizes.getSizeContainer(1,
        ph: BSizes.iconXs, pv: BSizes.sm, space: 0, icon: sizeButton);

    // Buttons to change assistance status
    final statusList = ItemListController.instance.attendance.value.listAttendanceToSelect();
    final buttons = List.generate(
        statusList.length,
        (index) => SelectAttendance(
            onTap: () => changeStatus(statusList[index].id), 
            color: statusList[index].color));
    return SizedBox(
        width: sizeGroupContainer.width,
        height: sizeGroupContainer.height,
        child: Center(
          child: Stack(children: [
            Visibility(
                visible: pressed,
                child: BRoundedContainer(
                    backgroundColor: dark ? BColors.grey : BColors.greenDark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: BSizes.sm, vertical: BSizes.sm),
                    size: sizeGroupContainer,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: buttons))),
            Visibility(
                visible: !pressed,
                child: BRoundedContainer(
                    backgroundColor: dark ? BColors.grey : BColors.greenDark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: BSizes.iconXs, vertical: BSizes.sm),
                    size: sizeSingleContainer,
                    child: SelectAttendance(onTap: onTap, color: status.color)))
          ]),
        ));
  }

  void changeStatus(int id) {
    final controller = AttendanceController.instance;
    controller.models.value[indexItem].changeStatus(id);
    onTap!();
  }
}
