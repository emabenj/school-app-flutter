import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/student_register_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  final _schoolRepository = SchoolRepository.instance;
  final _authRepository = AuthenticationRepository.instance;
  // VARIABLES
  final Rx<Roles> registerStatus = Roles.teacher.obs;
  final items = RxList<dynamic>([]);
  final controllers = List.generate(
      BTexts.fieldsRegister.length, (index) => TextEditingController());
  final List<String? Function(String?)> validators = [
    (value) => BValidator.validateLength(100, "Nombres", value),
    (value) => BValidator.validateLength(100, "Apellidos", value),
    (value) => BValidator.validateEmail(value),
    (value) => BValidator.validatePhoneNumber(value),
    (value) => BValidator.validateEmptyText("Dirección", value),
  ];
  final isPressedList = RxList<bool>([]);
  // AUTHORISED
  final dniController = TextEditingController();
  // TEACHER
  final birthDateController = TextEditingController();
  final genderId = 0.obs;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void setItems(List<dynamic> newItems) {
    items.value = newItems;
    if (_isTeacherStatus()) {
      isPressedList.value = List.generate(newItems.length, (index) => false);
    }
  }

  void setTeacherStatus() {
    registerStatus.value = Roles.teacher;
  }

  void setAuthorisedStatus() {
    registerStatus.value = Roles.authorised;
  }

  bool _isTeacherStatus() {
    return registerStatus.value == Roles.teacher;
  }

  void removeStudent(int index) {
    items.removeAt(index);
  }

  Future<void> searchStudent(String dni) async {
    await _authRepository.responseValidatorControllers(() async {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Buscando estudiante...', BImages.loadingSearchStudent);

      if (!items.map((student) => student.dni).contains(dni)) {
        final student = await _schoolRepository.getStudent(dni);
        items.add(student);
        BFullScreenLoader.stopLoading();
      } else {
        BLoaders.warningSnackBar(
            title: "Dni repetido", message: "Ingresar otro.");
      }
    }, fullScreenLoader: true, titleMessage: "Error al buscar estudiante.");
  }

  void changeStatusPressed(int index) {
    // FROM TEACHER
    for (var i = 0; i < isPressedList.length; i++) {
      isPressedList[i] = index == i;
    }
  }

  CourseModel _getIndexCourseSelected() {
    return items[isPressedList.indexOf(true)] as CourseModel;
  }

  Future<void> register() async {
    await _authRepository.responseValidatorControllers(() async {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Registrando...', BImages.loadingRegister);

      // FORM VALIDATION
      if (!registerFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      late String messageResponse;
      // INFO
      final nameRegister = controllers[0].text;
      final lastnameRegister = controllers[1].text;
      final emailRegister = controllers[2].text;
      final phoneNumberRegister = "+51 ${controllers[3].text}";
      final addressRegister = controllers[4].text;
      // REGISTER USER
      if (_isTeacherStatus()) {
        final genderIdTeacher = genderId.value;
        final courseId = _getIndexCourseSelected().id;
        final birthDateTeacher = birthDateController.text;
        messageResponse = await _schoolRepository.registerTeacher(
            nameRegister,
            lastnameRegister,
            emailRegister,
            phoneNumberRegister,
            addressRegister,
            genderIdTeacher,
            birthDateTeacher,
            courseId);
      } else {
        final idListStudents = items
            .map((student) => (student as StudentRegisterModel).id)
            .toList();
        messageResponse = await _schoolRepository.registerAuthorised(
            nameRegister,
            lastnameRegister,
            emailRegister,
            phoneNumberRegister,
            addressRegister,
            idListStudents);
      }
      BFullScreenLoader.stopLoading();
      Get.back();
      BLoaders.successSnackBar(title: 'Éxito', message: messageResponse);
    }, fullScreenLoader: true, titleMessage: "Error al registrar");
  }

  List<String? Function(String?)> getValidators() {
    return validators;
  }
}
