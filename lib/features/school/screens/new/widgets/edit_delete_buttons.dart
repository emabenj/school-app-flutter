import 'package:colegio_bnnm/common/widgets/buttons/container_icon_buttons.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class EditDeletNew extends StatelessWidget {
  const EditDeletNew({super.key, required this.onTap, required this.index});
  final void Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = NewsController.instance;
    // CONTAINER ROUNDED GREEN - 124w x 75h
    const crudActions = [Crud.edit, Crud.remove];
    final functions = List.generate(
        crudActions.length,
        (index) => () {
              controller.statusCrud.value = crudActions[index];
              onTap();
            });
    return ContainerIconButtons(
        widthContainer: BHelperFunctions.screenWidth() * .28,
        functions: functions,
        imgs: BImages.crudNews);
  }
}
