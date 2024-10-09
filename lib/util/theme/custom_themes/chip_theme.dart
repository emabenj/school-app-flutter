import 'package:flutter/material.dart';

class BChipTheme {
  BChipTheme._();

  static final lightChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(.4),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: Colors.blue,//CHANGE
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white);

  static const darkChipTheme = ChipThemeData(
      disabledColor: Colors.grey,
      labelStyle: TextStyle(color: Colors.white),
      selectedColor: Colors.blue,//CHANGE
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white);
}
