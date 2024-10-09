import 'package:colegio_bnnm/common/widgets/buttons/container_icon_buttons.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';
import 'package:get/get.dart';

class CrudButtonsTop extends StatelessWidget {
  const CrudButtonsTop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeworkController.instance;
    const imgs = BImages.crudHomework;
    final actions = List.generate(
        imgs.length,
        (index) => () =>controller.crudAction(index));
    // final sizeContainer = BSizes.getSizeContainer(imgs.length,
    // icon: BSizes.iconLg, ph: BSizes.xs, pv: 0, space: BSizes.spaceBtwItems);
    return Obx(()=> ContainerIconButtons(
          padding: 0.0,
          // widthContainer: sizeContainer.width,
          sizeIconButton: const Size(BSizes.iconLg, BSizes.iconLg),
          imgs: imgs,
          functions: actions,
          enabled: controller.getButtons(),
          color: Colors.transparent),
    );
  }
}
