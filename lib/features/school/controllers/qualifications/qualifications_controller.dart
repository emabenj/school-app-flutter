import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/models/qualifications/qualifications_model.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/util/helpers/calculator.dart';
import 'package:get/get.dart';

class QualificationsController extends GetxController {
  static QualificationsController get instance => Get.find();
  int studentId = 0;
  String studentName = "";
  //VARIABLES
  final model = QualificationsModel.empty().obs;
  final Rx<double> average = 0.0.obs;
  // FORM
  GlobalKey<FormState> qualificationFormKey = GlobalKey<FormState>();

  final List<TextEditingController> textControllers = RxList([
    TextEditingController(), // QUALIFICATION #1
    TextEditingController(), // QUALIFICATION #2
    TextEditingController(), // QUALIFICATION #3
    TextEditingController(), // QUALIFICATION #4
    TextEditingController() // AVERAGE
  ]);

  Future<void> searchQualifications() async {
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      model.value =
          await SchoolRepository.instance.getQualifications(studentId);

      textControllers[0].text = model.value.qualification1.toString();
      textControllers[1].text = model.value.qualification2.toString();
      textControllers[2].text = model.value.qualification3.toString();
      textControllers[3].text = model.value.qualification4.toString();
      textControllers[4].text = model.value.average.toString();
    }, back: true, titleMessage: "Error buscando las calificaciones");
  }

  List<TextEditingController> getQualificationControllers() {
    return textControllers.sublist(0, textControllers.length - 1);
  }

  TextEditingController getAverageController() {
    return textControllers.last;
  }

  void calculateAverage() {
    // FORM VALIDATE
    if (!qualificationFormKey.currentState!.validate()) {
      return;
    }
    final qualifications = List.generate(getQualificationControllers().length,
        (index) => double.parse(getQualificationControllers()[index].text));
    final averageCalculated = BCalculator.calculateAverage(qualifications);
    average.value = double.parse(averageCalculated);
    setAverage();
  }

  void qualificationChanged(int index) {
    final text = textControllers[index].text;
    if (text.isEmpty) {
      setNumber(index, 0);
      return;
    }
    calculateAverage();
  }

  void setNumber(int index, double number) {
    textControllers[index].text = number.toString();
  }

  void setAverage() {
    setNumber(textControllers.length - 1, average.value);
  }

  Future<void> saveChanges() async {
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Guardando notas', BImages.loadingQualifications);

      // FORM VALIDATION
      if (!qualificationFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      // INFO
      final id = model.value.id;
      final q1 = double.parse(textControllers[0].text);
      final q2 = double.parse(textControllers[1].text);
      final q3 = double.parse(textControllers[2].text);
      final q4 = double.parse(textControllers[3].text);
      await SchoolRepository.instance.updateQualifications(id, q1, q2, q3, q4);
      BFullScreenLoader.stopLoading();
      Get.back();
      BLoaders.successSnackBar(title: 'Éxito', message: "Notas actualizadas.");
    }, fullScreenLoader: true, titleMessage: "Error guardando cambios");
  }
}
