import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/authentication/controllers/login/login_controller.dart';
import 'package:colegio_bnnm/features/personalization/screens/reset_password/reset_password_screen.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerForm extends StatelessWidget {
  const ContainerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    final textStyle =
        Theme.of(context).textTheme.labelMedium!.apply(color: BColors.white);
    return Form(
        key: controller.loginFormKey,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: BSizes.spaceBtnSections),
            child: Column(children: [
              // EMAIL
              TextFormField(
                  controller: controller.emailController,
                  validator: (value) => BValidator.validateEmail(value),
                  style: textStyle,
                  decoration: const InputDecoration(
                      labelText: BTexts.fieldEmail,
                      prefixIcon: Icon(Icons.email))),
              const SizedBox(height: BSizes.spaceBtwInputFields),
              // PASSWORD
              Obx(
                () => TextFormField(
                    controller: controller.passwordController,
                    validator: (value) =>
                        BValidator.validateEmptyText("Password", value),
                    obscureText: !controller.showPass.value,
                    style: textStyle,
                    decoration: InputDecoration(
                        labelText: BTexts.fieldPassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(!controller.showPass.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => controller.showPass.value =
                                !controller.showPass.value))),
              ),
              const SizedBox(height: BSizes.spaceBtwInputFields / 2),
              //REMEMBER ME AND FORGET PASSWORD
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.keepSession.value,
                          onChanged: (value) => controller.keepSession.value =
                              !controller.keepSession.value),
                    ),
                    const Text(BTexts.loginRemeberMe)
                  ],
                ),
                TextButton(
                    onPressed: () => Get.to(() => const ResetPasswordScreen()),
                    child: const Text(BTexts.loginForget))
              ]),
              const SizedBox(
                height: BSizes.spaceBtnSections,
              ),
              // LOGIN BUTTON
              BElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  // final email = controllerEmail.obs.value.text.toUpperCase();
                  // final controller = Get.put(NavigationController());
                  // final newsController = Get.put(NewsController());
                  // if (email == "TE") {
                  //   controller.setUser(TeacherItemModel(
                  //       "Benjamín Enmanuel", "Carrillo Apaza", Courses.math));
                  // } else if (email == "AU") {
                  //   controller.setUser(ParentItemModel(
                  //       "Benjamín Enmanuel", "Carrillo Apaza"));
                  // } else {
                  //   controller.setUser(UserItemModel(
                  //       "Enmanuel Benjamín", "Carrillo Apaza",
                  //       role: Roles.admin));
                  //   newsController.forA.value = true;
                  // }

                  // Get.to(() => const NavigationMenu());
                  text: BTexts.loginBtn)
            ])));
  }
}
