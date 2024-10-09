import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';
import 'package:colegio_bnnm/features/school/models/homework/details_homework_model.dart';
import 'package:colegio_bnnm/features/school/screens/homework/widgets/crud_buttons_item.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class DetailsHomework extends StatelessWidget {
  const DetailsHomework(
      {super.key,
      required this.model,
      required this.pressed,
      required this.onTap, required this.index});
  final DetailsHomeworkModel model;
  final int index;
  final void Function() onTap;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    final sizeCrudButtons = BSizes.getSizeContainer(2,
        icon: BSizes.iconButtonMd, ph: 0, pv: 0, space: BSizes.xs, row: false);
    return GestureDetector(
        onTap: onTap,
        child: BRoundedContainer(
            padding: const EdgeInsets.all(BSizes.sm),
            backgroundColor: BHelperFunctions.isDarkMode(context)
                ? BColors.grey
                : BColors.white,
            size: Size(double.infinity, sizeCrudButtons.height + BSizes.sm * 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                      visible: !pressed,
                      child: Image.asset(BImages.qualifications,
                          fit: BoxFit.fill, width: BSizes.iconButtonMd)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // HOMEWORK TITLE
                        Text(model.title,
                            style: Theme.of(context).textTheme.headlineSmall),
                        Row(children: [
                          // HOMEWORK DESCRIPTION
                          SizedBox(
                              width: BHelperFunctions.screenWidth() * .51,
                              child: Text(model.description, maxLines: 2)),
                          const SizedBox(width: BSizes.sm),
                          // VIEW COUNT OF STUDENTS COMPLETED
                          Text("0/${HomeworkController.instance.studentsTotal}",
                              style: Theme.of(context).textTheme.titleLarge)
                        ])
                      ]),
                  Visibility(visible: pressed, child: CrudButtonsItem(index: index))
                ])));
  }
}
