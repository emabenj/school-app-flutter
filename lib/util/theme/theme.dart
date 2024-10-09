import 'package:colegio_bnnm/util/theme/custom_themes/appbar_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/checkbox_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/chip_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/dropdown_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/elevated_button_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/outlined_button_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/text_field_theme.dart';
import 'package:colegio_bnnm/util/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

const _light = Color(0xffD8E4FF);
const _dark = Color(0xFF39423F);

class BAppTheme {
  BAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      // fontFamily: ,
      brightness: Brightness.light,
      primaryColor: Colors.orange, //CHANGE
      textTheme: BTextTheme.lightTextTheme,
      chipTheme: BChipTheme.lightChipTheme,
      scaffoldBackgroundColor: _light,
      appBarTheme: BAppBarTheme.lightAppBarTheme,
      checkboxTheme: BCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: BBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: BElevatedButtonTheme.lightElevatedButtonTheme,
      dropdownMenuTheme: BDropDownMenuTheme.lightDropDownMenuTheme,
      menuButtonTheme: BDropDownMenuTheme.lightMenuButtonThemeData,
      outlinedButtonTheme: BOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: BTextFieldTheme.lightInputDecorationTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      // fontFamily: ,
      brightness: Brightness.dark,
      primaryColor: Colors.orange, //CHANGE
      textTheme: BTextTheme.darkTextTheme,
      chipTheme: BChipTheme.darkChipTheme,
      scaffoldBackgroundColor: _dark,
      appBarTheme: BAppBarTheme.darkAppBarTheme,
      checkboxTheme: BCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: BBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: BElevatedButtonTheme.darkElevatedButtonTheme,
      dropdownMenuTheme: BDropDownMenuTheme.darkDropDownMenuTheme,
      menuButtonTheme: BDropDownMenuTheme.darkMenuButtonThemeData,
      outlinedButtonTheme: BOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: BTextFieldTheme.darkInputDecorationTheme);
}
