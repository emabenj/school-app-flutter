import 'package:colegio_bnnm/features/school/controllers/qualifications/qualifications_controller.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QualificationItem extends StatelessWidget {
  const QualificationItem(
      {super.key,
      required this.text,
      required this.textController,
      this.isAverage = false,
      this.index});
  final String text;
  final TextEditingController textController;
  final int? index;
  final bool isAverage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QualificationsController());
    return SizedBox(
        width: BHelperFunctions.screenWidth() * .65, //88
        child: Column(children: [
          Row(children: [
            SizedBox(
                height: isAverage
                    ? BSizes.spaceBtwInputFields + BSizes.sm
                    : index! != 0
                        ? BSizes.spaceBtwInputFields
                        : 0),
            // QUALIFICATION NUMBER
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(width: BSizes.spaceBtwItems),
            // QUALIFICATION TEXTFIELD
            Expanded(
                child: TextFormField(
                    onChanged: isAverage
                        ? null
                        : (value) =>
                            controller.qualificationChanged(index!),
                    controller: textController,
                    readOnly: isAverage,
                    validator: (value) => isAverage
                        ? null
                        : BValidator.validateQualification(value),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}(\.\d{0,1})?$'))
                ]))
          ])
        ]));
  }
}
