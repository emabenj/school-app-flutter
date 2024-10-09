import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/features/authentication/controllers/login/login_controller.dart';
import 'package:colegio_bnnm/features/authentication/screens/login/widgets/container_form.dart';
import 'package:colegio_bnnm/features/authentication/screens/login/widgets/header_login.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: BSpacingStyles.paddingWithAppBarHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderLogin(),
                      const ContainerForm(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Divider(
                                  color: dark ? BColors.darkGrey : BColors.grey,
                                  thickness: .5,
                                  indent: 60,
                                  endIndent: 5),
                            ),
                            Text(BTexts.loginStill,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Flexible(
                                child: Divider(
                                    color:
                                        dark ? BColors.darkGrey : BColors.grey,
                                    thickness: .5,
                                    indent: 5,
                                    endIndent: 60))
                          ]),
                      Center(
                        child: TextButton(
                            onPressed: () => controller.onlySeeNews(),
                            child: Text(BTexts.loginSeeNews,
                                style: Theme.of(context).textTheme.bodyLarge)),
                      )
                    ]))));
  }
}
