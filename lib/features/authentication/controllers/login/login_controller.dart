import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/exceptions/api_auth_exceptions.dart';
import 'package:colegio_bnnm/util/helpers/network_manager.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final _authRep = AuthenticationRepository.instance;
  // VARIABLES
  final emailController = TextEditingController(text: "docente@hotmail.com");
  final passwordController = TextEditingController(text: r"uUgjThiCQ9");

  final keepSession = false.obs;
  final showPass = false.obs;

  final localStorage = GetStorage();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Logging you in...', BImages.loadingLoginLoading);

      // CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      String emailText = emailController.text.trim();
      String passwordText = passwordController.text.trim();

      // LOGIN USER USING EMAIL AND PASSWORD AUTHENTICATION
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(emailText, passwordText);

      // SAVE IF REMEMBER ME IS SELECTED
      if (keepSession.value) {
        localStorage.write(BTexts.keyRememberEmail, emailText);
        localStorage.write(BTexts.keyRememberPass, passwordText);
        localStorage.write(
            BTexts.keyRememberRole, _authRep.currentUser()!.role.name);
      }

      // REDIRECT
      await _authRep.screenRedirect();
    } catch (e) {
      String messageError = "$e";
      if (e is BApiAuthException) {
        messageError = e.message;
      }
      BFullScreenLoader.stopLoading();
      if (messageError != "Exception") {
        BLoaders.errorSnackBar(title: 'Oh Snap!', message: messageError);
      }
    }
  }

  Future<void> onlySeeNews() async {
    _authRep.guestMode.value = true;
    NavigationController.instance.setUser(UserAuthenticatedModel.empty());
    _authRep.loginOut();
  }
}
