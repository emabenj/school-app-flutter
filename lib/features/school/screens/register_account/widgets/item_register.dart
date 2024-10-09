import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/student_register_model.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ItemRegister extends StatelessWidget {
  final dynamic model;
  final bool forT;
  final void Function()? onTap;
  final void Function()? onDelete;
  final bool? pressed;
  const ItemRegister(
      {super.key,
      required this.model,
      required this.forT,
      required this.onTap,
      this.pressed, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final text = forT
        ? (model as CourseModel).name
        : (model as StudentRegisterModel).fullName;

    final backgroundColor = dark ? BColors.light : BColors.dark;
    return Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(BSizes.sm),
              decoration: BoxDecoration(
                  color: pressed ?? false
                      ? (model as CourseModel).getcolor(): backgroundColor,
                  borderRadius: BorderRadius.circular(BSizes.borderRadiusSm)),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                    child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: dark ? BColors.dark : BColors.light),
                )),
                forT
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.delete), onPressed: onDelete),
              ]))
    ));
  }
}
