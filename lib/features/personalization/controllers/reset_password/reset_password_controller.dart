import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // TextControllers
  final emailController = TextEditingController();

  void sendEmail() {
    // print("Se envió el correo a ${emailController.text}");
  }
}
