import 'package:colegio_bnnm/common/widgets/buttons/container_icon_buttons.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';

class CrudButtonsItem extends StatelessWidget {
  const CrudButtonsItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final imgs = BImages.crudHomework.sublist(1);
    return ContainerIconButtons(
        padding: 0.0,
        // widthContainer: sizeContainer.width,
        sizeIconButton: const Size(BSizes.iconButtonMd, BSizes.iconButtonMd),
        imgs: imgs,
        functions: List.generate(
        imgs.length,
        (i) => () {
              HomeworkController.instance.changeState(Crud.values[i + 1], modelIndex: index);
            }),
        color: Colors.transparent,
        row: false);
  }
}
