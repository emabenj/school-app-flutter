import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/teacher_item_model.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/user_item_vertical.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class TeacherItem extends StatelessWidget {
  const TeacherItem(
      {super.key,
      required this.model,
      required this.onTap,
      // required this.online
      });
  final TeacherItemModel model;
  final void Function() onTap;
  // final bool online;
  @override
  Widget build(BuildContext context) {
    const textColor = BColors.white;
    return GestureDetector(
      onTap: onTap,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: BSizes.spaceBtwInputFields),
        UserItemVertical(
            img: model.getCourseImg(),
            online: model.online,
            content: Column(children: [
              Text(model.getText(),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.titleMedium!.apply(color: textColor)),
              const SizedBox(height: BSizes.spaceBtwInputFields),
              BRoundedContainer(
                backgroundColor: model.getColor(),
                padding: const EdgeInsets.all(BSizes.sm),
                child: Text(model.getCourseName(),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleLarge!.apply(color: textColor)),
              )
            ]))
      ]),
    );
  }
}
