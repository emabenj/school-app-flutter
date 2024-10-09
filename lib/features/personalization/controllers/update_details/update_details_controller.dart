// import 'package:colegio_bnnm/features/authentication/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/personalization/personalization_repository.dart';
import 'package:colegio_bnnm/features/personalization/models/user_update_model.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDetailsController extends GetxController {
  final _authRepository = AuthenticationRepository.instance;

  // VARIABLES
  final labels = BTexts.updateFields;
  final user = UserUpdateModel.fromUserAuthenticated(
      AuthenticationRepository.instance.currentUser()!);
  List<TextEditingController> controllers = [];
  GlobalKey<FormState> updateDetailsFormKey = GlobalKey<FormState>();

  List<TextEditingController> getControllers() {
    if (controllers.isEmpty) {
      final texts = [user.email, user.phoneNumber, user.address];
      controllers = List.generate(BTexts.updateFields.length,
          (index) => TextEditingController(text: texts[index]));
    }
    return controllers;
  }

  final List<String? Function(String?)> validators = [
    (value) => BValidator.validateEmail(value),
    (value) => BValidator.validatePhoneNumber(value),
    (value) => BValidator.validateEmptyText("Dirección", value),
  ];

  Future<void> updateDetails() async {
    await _authRepository.responseValidatorControllers(() async {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Actualizando información', BImages.loadingSearchStudent);

      // FORM VALIDATION
      if (!updateDetailsFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }

      // INFO
      final emailUpdate = controllers[0].text;
      final phoneNumberUpdate = controllers[1].text;
      final addressUpdate = controllers[2].text;
      // UPDATE DETAILS
      late String messageResponse;
      messageResponse = await PersonalizationRepository.instance
          .updateUser(emailUpdate, phoneNumberUpdate, addressUpdate);
      _authRepository.currentUser()!.user.updateEmail(emailUpdate);
      _authRepository.currentUser()!.user.updatePhoneNumber(phoneNumberUpdate);
      _authRepository.currentUser()!.user.updateAddress(addressUpdate);
      _authRepository.currentUser()!.user.updateAllowToUpdate(DateTime.now());
      BFullScreenLoader.stopLoading();
      Get.back();
      BLoaders.successSnackBar(title: "Éxito", message: messageResponse);
    }, fullScreenLoader: true, titleMessage: "Error al actualizar datos");
  }
}
