import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:colegio_bnnm/features/school/screens/home/home_screen.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final Rx<UserAuthenticatedModel> _user = UserAuthenticatedModel.empty().obs;

  Roles getRole() {
    return _user.value.role;
  }

  void setUser(UserAuthenticatedModel newUser) {
    _user.value = newUser;
  }

  UserForHome getUser() {
    final authUser = _user.value.user;
    return UserForHome(authUser.name, authUser.lastname, getRole());
  }

  Color getColorRole() {
    return BColors.roles(role: getRole());
  }

  bool isAdmin() {
    return getRole() == Roles.admin;
  }

  bool isTeacher() {
    return getRole() == Roles.teacher;
  }

  bool isAuthorised() {
    return getRole() == Roles.authorised;
  }

  bool teacherOrAuthorised() {
    return isAuthorised() || isTeacher();
  }

  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), Container(color: Colors.yellow)];
}
