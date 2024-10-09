import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';
import 'package:colegio_bnnm/features/school/screens/homework/widgets/crud_buttons_top.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkContainer extends StatefulWidget {
  const HomeworkContainer({super.key});

  @override
  State<HomeworkContainer> createState() => _HomeworkContainerState();
}

class _HomeworkContainerState extends State<HomeworkContainer> {
  final controller = HomeworkController.instance;
  @override
  Widget build(BuildContext context) {
    final backgroundItems =
        BHelperFunctions.isDarkMode(context) ? BColors.grey : BColors.white;

    const decorationConfirm = BoxDecoration(
        color: BColors.redLight,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd)));
    final decorationDescription = InputDecoration(
        hintText: BTexts.homeworkLabelDescription,
        filled: true,
        fillColor: backgroundItems,
        // alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BRadiusStyles.radius[Rounded.backChatRMd]!),
        focusedBorder: OutlineInputBorder(
            borderRadius: BRadiusStyles.radius[Rounded.backChatRMd]!));
    final decorationDescriptionRemoving = InputDecoration(
        hintText: BTexts.homeworkLabelDescription,
        filled: true,
        fillColor: backgroundItems,
        // alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BRadiusStyles.radius[Rounded.upMd]!),
        focusedBorder: OutlineInputBorder(
            borderRadius: BRadiusStyles.radius[Rounded.upMd]!));
    final decorationDate = InputDecoration(
        hintText: BTexts.homeworkLabelDate,
        filled: true,
        fillColor: backgroundItems,
        enabledBorder: OutlineInputBorder(
          borderRadius: BRadiusStyles.radius[Rounded.chatRMd]!,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BRadiusStyles.radius[Rounded.chatRMd]!));

    return Form(
      key: controller.homeworkFormKey,
      child: Obx(()=> Column(children: [
            // DESCRIPTION
            Expanded(
                child: TextFormField(
                  validator: (value) => BValidator.validateEmptyText("Descripción", value),
                  controller: controller.descriptionController,
                  maxLines: controller.isRemoving() ? 7 : 8,
                  keyboardType: TextInputType.multiline,
                  decoration: controller.isRemoving()
                      ? decorationDescriptionRemoving
                      : decorationDescription,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center)),
            Visibility(
                visible: controller.isRemoving(),
                child: Container(
                    width: double.infinity,
                    decoration: decorationConfirm,
                    child: Text(BTexts.homeworkRemoveConfirm,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: Colors.white)))),
            const SizedBox(height: BSizes.sm),
            Row(children: [
              // CRUD BUTTONS
              const CrudButtonsTop(),
              const SizedBox(width: BSizes.spaceBtwItems),
              // DATE
              Expanded(
                  child: TextFormField(
                    validator: (value) => BValidator.validateDate("entrega", value),
                      controller: controller.dateController,
                      decoration: decorationDate,
                      readOnly: true,
                      onTap: _selectedDate))
            ])
          ]),
      ),
    );
  }

  Future<void> _selectedDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 12));
    if (picked != null) {
      setState(() {
        controller.dateController.text = BFormatter.formatDateToString(picked);
      });
    }
  }
}
