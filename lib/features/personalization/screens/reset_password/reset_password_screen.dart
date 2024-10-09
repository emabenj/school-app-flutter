import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/personalization/controllers/reset_password/reset_password_controller.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding: BSpacingStyles.paddingWithAppBarHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(BTexts.resetTitle,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: BSizes.sm),
                      Text(
                        BTexts.resetSubTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      Form(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: BSizes.spaceBtnSections),
                              child: TextFormField(
                                  controller: controller.emailController,
                                  decoration: const InputDecoration(
                                    labelText: BTexts.fieldEmail,
                                    prefixIcon: Icon(Icons.email),
                                  )))),
                      BElevatedButton(
                          onPressed: controller.sendEmail,
                          text: BTexts.resetBtn)
                    ]))));
  }
}
