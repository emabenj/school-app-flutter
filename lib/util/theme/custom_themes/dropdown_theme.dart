import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/text_field_theme.dart';
import 'package:flutter/material.dart';

class BDropDownMenuTheme {
  BDropDownMenuTheme._();
  static final lightDropDownMenuTheme = DropdownMenuThemeData(
      inputDecorationTheme: BTextFieldTheme.lightInputDecorationTheme,
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll(BColors.grey),
      ));
  static const lightMenuButtonThemeData =MenuButtonThemeData(
      style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: BSizes.sm))));

  static final darkDropDownMenuTheme = DropdownMenuThemeData(
      inputDecorationTheme: BTextFieldTheme.darkInputDecorationTheme,
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll(BColors.grey),
      ));
  static const darkMenuButtonThemeData = MenuButtonThemeData(
      style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: BSizes.sm))));
}
