import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/screens/select/widgets/container_list.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/common/widgets/containers/selected_container.dart';
import 'package:colegio_bnnm/features/school/screens/select/widgets/extra_buttons_group.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key, required this.forT});
  final bool forT;

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  final controller = SelectController.instance;
  final buttonSize =
      const Size(double.infinity, BSizes.iconContainer + BSizes.sm * 2);
  bool extraButtonState = false;
  @override
  void initState() {
    super.initState();
    controller.counterSelect.value = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BAppBar(
            title: Text(controller.counterSelect.value == 1 || controller.selectMessageToTeachers()
                ? BTexts.selectTitleForA
                : BTexts.selectTitleForT),
            showBackArrow: true),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(BSizes.defaultSpace),
                child: Column(children: [
                  // CONTAINER LIST
                  ContainerList(forT: widget.forT),
                  Obx(() => SizedBox(
                      height: controller.showExtra.value
                          ? BSizes.xs
                          : BSizes.xs + controller.heightExtraLg)),
                  // BUTTON
                  Obx(() => Visibility(
                      visible: controller.selectingRoom(),
                      child: Column(children: [
                        Visibility(
                            visible: controller.showExtra.value,
                            child: const ExtraButtonsGroupContainer(
                                forButton: true)),
                        BSelectedContainer(
                            onTap: () {
                              controller.changeButtonState();
                              extraButtonState = controller.showExtra.value;
                              setState(() {});
                            },
                            pressed: controller.buttonPressed.value,
                            colorOpacity: BHelperFunctions.isDarkMode(context)
                                ? BColors.light
                                : BColors.black,
                            radius: true,
                            withOpacity: false,
                            size: buttonSize,
                            child: BRoundedContainer(
                                backgroundColor: BColors.greenDark,
                                size: buttonSize,
                                child: const Text("Seleccionar aulas")))
                      ])))
                ]))));
  }
}
