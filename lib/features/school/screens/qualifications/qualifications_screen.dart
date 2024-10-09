import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/school/controllers/qualifications/qualifications_controller.dart';
import 'package:colegio_bnnm/features/school/screens/qualifications/widgets/qualification_list.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';

class QualificationsScreen extends StatelessWidget {
  const QualificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QualificationsController.instance;
    return Scaffold(
        appBar: const BAppBar(showBackArrow: true),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(BSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // NAME
                      Text(controller.studentName,
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: BSizes.spaceBtnSections),
                      // LIST NOTES
                      const QualificationList(),
                      const SizedBox(height: BSizes.spaceBtnSections),
                      // BUTTON
                      BElevatedButton(
                          text: BTexts.saveChanges,
                          onPressed: () => controller.saveChanges())
                    ]))));
  }
}
