import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';
import 'package:flutter/material.dart';

class BColors {
  BColors._();

  static const black = Color(0xff00120B);
  static const greenDark = Color(0xff35605A);
  static const grey = Color(0xff6B818C);
  static const light = Color(0xffD8E4FF);
  static const dark = Color(0xFF39423F);
  static const greenLight = Color(0xff31E981);
  static const greenLightTwo = Color(0xffA2FECA);
  static const redLight = Color(0xffF87575);
  static const yellow = Color(0xffF2CD60);

  // APP BASIC COLORS 3
  static const primary = Color(0xFF4B68FF);
  static const secondary = Color(0xFFFFE248);
  static const accent = Color(0xFFB0C7FF);

  // TEXT COLORS 3
  static const textPrimary = Color(0xFF333333);
  static const textSecondary = Color(0xFF6C7570);
  static const textWhite = Colors.white;

  // BACKGROUND COLORS 3
  // static const light = Color(0xFFF6F6F6);
  // static const dark = Color(0xFF272727);
  static const primaryBackground = Color(0xFFF3F5FF);

  // BACKGROUND CONTAINER COLORS 2
  static const lightContainer = Color(0xFFF6F6F6);
  static final darkContainer = BColors.white.withOpacity(.1);

  // BUTTON COLORS 3
  static const buttonPrimary = Color(0xFF4B68FF);
  static const buttonSecondary = Color(0xFF6C7570);
  static const buttonDisabled = Color(0xFFC4C4C4);

  // BORDER COLORS 2
  static const borderPrimary = Color(0xFF090909);
  static const borderSecondary = Color(0xFFE6E6E6);

  // ERROR AND VALIDATION COLORS 4
  static const error = Color(0xFF032F2F);
  static const success = Color(0xFF388E3C);
  static const warning = Color(0xFFF57C00);
  static const info = Color(0xFF197602);

  // NEUTRAL SHADES 7
  // static const black = Color(0xFF232323);
  static const darkerGrey = Color(0xFF4F4F4F);
  static const darkGrey = Color(0xFF939393);
  // static const grey = Color(0xFFE0E0E0);
  static const softGrey = Color(0xFFF4F4F4);
  static const lightGrey = Color(0xFFF9F9F9);
  static const white = Color(0xFFFFFFFF);

  // CHAT
  static const leftMessage = Color(0xffBA3838);
  static const rightMessage = Color(0xff8CAAA5);

  // COURSES COLORS
  static const coursesColors = [
    Color(0xff44A1A0),
    Color(0xff655f68),
    Color(0xff65655E),
    Color(0xffD33F49),
    Color(0xff2a34c1),
    Color(0xff00a855),
    Color(0xff655f68)
  ];

  // ROLE COLORS
  static final _roleColors = [greenDark, grey, redLight, Colors.orange];
  
  static Color roles({Roles? role, String? roleName}) {
    if (roleName != null) {
      return roles(role: BAuthMapper.role(roleName));
    } else if (role != null) {
      return _roleColors[Roles.values.indexOf(role)];
    } else {
      return primary;
    }
  }

  // GRADIENT COLORS
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(.0, .0),
      end: Alignment(.707, -.707),
      colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4), Color(0xFFFAD0C4)]);
}
