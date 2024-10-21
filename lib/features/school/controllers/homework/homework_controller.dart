import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/models/homework/homework_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkController extends GetxController {
  static HomeworkController get instance => Get.find();
  final _schoolRepository = SchoolRepository.instance;
  final _authRepository = AuthenticationRepository.instance;
  int classroomId = 0;
  int studentsTotal = 0;
  //VARIABLES
  final models = RxList<HomeworkModel>([]); //CHANGED
  final isPressedList = RxList<bool>([]);
  final state = Crud.insert.obs;
  final modelSelected = HomeworkModel.empty().obs;
  //TEXTEDITINGCONTROLLERS
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  GlobalKey<FormState> homeworkFormKey = GlobalKey<FormState>();

  Future<void> loadData() async {
    await _authRepository.responseValidatorControllers(() async {
      models.value =
          await SchoolRepository.instance.getHomeworkByClassroom(classroomId);
      isPressedList.value = List.generate(models.length, (index) => false);
    }, back: true, titleMessage: "Error al buscar tareas");
  }

  void setModel(HomeworkModel newModel) {
    modelSelected.value = newModel;
    descriptionController.text = newModel.description;
    dateController.text = newModel.date();
  }

  void changeStatePressed(int index) {
    isPressedList[index] = !isPressedList[index];
    changeState(Crud.insert);
  }

  // ENABLE STATUS
  final imgsCrudButtons = BImages.crudHomework;
  final buttonsConfirm = Rx<List<bool>>(
      List.generate(BImages.crudHomework.length, (index) => false));

  List<bool> getButtons() {
    if (isInserting()) {
      buttonsConfirm.value[0] = true;
    }
    return buttonsConfirm.value;
  }

  void changeState(Crud newState, {int? modelIndex}) {
    state.value = newState;
    buttonsConfirm.value =
        List.generate(BImages.crudHomework.length, (index) => false);
    if (!isInserting()) {
      setModel(models[modelIndex!]);
      final index = Crud.values.indexOf(newState);
      buttonsConfirm.value[index] = true;
    } else {
      setModel(HomeworkModel.empty());
    }
  }

  bool isInserting() {
    return state.value == Crud.insert;
  }

  bool isEditing() {
    return state.value == Crud.edit;
  }

  bool isRemoving() {
    return state.value == Crud.remove;
  }

  Future<void> crudAction(int crudActionIndex) async {
    final action = isInserting()
        ? "agregar"
        : isEditing()
            ? "editar"
            : "eliminar";
    await _authRepository.responseValidatorControllers(() async {
      // FORM VALIDATION
      if (!homeworkFormKey.currentState!.validate()) {
        return;
      }

      // INFO

      final homeworkId = modelSelected.value.id;
      final homeworkDescription = descriptionController.text;
      final dueDate = BFormatter.correctFormatStringDate(dateController.text);
      late String response;
      // ACTION
      if (isInserting() && crudActionIndex == 0) {
        final newModel = await _schoolRepository.addHomework(
            classroomId, homeworkDescription, dueDate);
        models.insert(0, newModel);
        isPressedList.insert(0, false);
        response = "Tarea agregada.";
      } else if (isEditing() && crudActionIndex == 1) {
        final updatedModel = await _schoolRepository.editHomework(
            homeworkId, homeworkDescription, dueDate);
        final index = models.indexWhere((h) => h.id == homeworkId);
        models[index] = updatedModel;
        isPressedList[index] = false;
        response = "Tarea editada";
      } else if (isRemoving() && crudActionIndex == 2) {
        response = await _schoolRepository.deleteHomework(homeworkId);
        final index = models.indexWhere((h) => h.id == homeworkId);
        models.removeWhere((homework) => homework.id == homeworkId);
        isPressedList.removeAt(index);
      }

      changeState(Crud.insert);
      BLoaders.successSnackBar(title: 'Éxito', message: response);
    }, titleMessage: "Error al $action la tarea");
  }
}
