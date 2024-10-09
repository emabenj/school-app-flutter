import 'package:colegio_bnnm/bindings/general_bindings.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    // GET role if password reminder was set
    final roleAuth = storage.read(BTexts.keyRememberRole);
    // GET color role
    final backgroundColor = BColors.roles(roleName: roleAuth);
    return GetMaterialApp(
        title: "Colegio BNNM",
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: BAppTheme.lightTheme,
        darkTheme: BAppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        home: Scaffold(
            backgroundColor: backgroundColor,
            body: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )))
        );
  }
}
