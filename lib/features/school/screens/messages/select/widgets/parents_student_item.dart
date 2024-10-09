import 'package:colegio_bnnm/common/widgets/containers/selected_container.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/student_item_model.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/authorised_item.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ParentsStudentItem extends StatelessWidget {
  const ParentsStudentItem(
      {super.key,
      required this.model,
      required this.pressed,
      required this.onTap});
  final StudentItemModel model;
  final void Function() onTap;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    final parentsTotal = model.parents.length;
    const sizeCircle = BSizes.iconContainer;
    const secondCircle = sizeCircle * .46;

    final parentsWidgets = List.generate(
        parentsTotal, (index) => AuthorisedItem(model: model.parents[index]));
    final sizeContainer = Size(
        parentsTotal * sizeCircle + (parentsTotal - 1) * BSizes.sm,
        BHelperFunctions.screenHeight() * .25);
    const textColor = BColors.white;

    return BSelectedContainer(
        onTap: onTap,
        pressed: pressed,
        colorOpacity: BColors.greenLightTwo,
        size: sizeContainer,
        radius: true,
        child: SizedBox(
            width: sizeContainer.width,
            height: sizeContainer.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: sizeContainer.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: parentsWidgets)),
                  Column(children: [
                    Text(model.getText(),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: textColor)),
                    Image.asset(model.getImg(),
                        width: secondCircle, fit: BoxFit.cover)
                  ])
                ])));
  }
}
