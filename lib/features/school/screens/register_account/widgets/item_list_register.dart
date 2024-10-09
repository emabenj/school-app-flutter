import 'package:colegio_bnnm/features/school/controllers/register_account/register_controller.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/widgets/item_register.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemListRegister extends StatefulWidget {
  const ItemListRegister({super.key, required this.forT});
  final bool forT;

  @override
  State<ItemListRegister> createState() => _ItemListRegisterState();
}

class _ItemListRegisterState extends State<ItemListRegister> {
  final controller = RegisterController.instance;

  @override
  void initState() {
    super.initState();
    widget.forT
        ? controller.setTeacherStatus()
        : controller.setAuthorisedStatus();
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Container(
        height: BHelperFunctions.screenHeight() * .3,
        padding: const EdgeInsets.all(BSizes.xs),
        decoration: BoxDecoration(
            border: Border.all(color: dark ? BColors.light : BColors.dark),
            borderRadius: BorderRadius.circular(BSizes.borderRadiusSm)),
        child: Obx(() => ListView.separated(
            shrinkWrap: true,
            itemCount: controller.items.length,
            itemBuilder: (context, index) => ItemRegister(
                  model: controller.items[index],
                  forT: widget.forT,
                  onTap: () => changeStatusPressed(index),
                  onDelete: () => changeStatusPressed(index, forRemove: true),
                  pressed: widget.forT ? controller.isPressedList[index] : null,
                ),
            separatorBuilder: (context, index) =>
                const SizedBox(height: BSizes.xs))));
  }

  void changeStatusPressed(int index, {bool forRemove = false}) {
    setState(() {
      widget.forT && !forRemove
          ? controller.changeStatusPressed(index)
          : forRemove
              ? controller.removeStudent(index)
              : null;
    });
  }
}
