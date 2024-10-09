import 'package:colegio_bnnm/features/school/controllers/attendance/attendance_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/homework/homework_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/qualifications/qualifications_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/attendance_screen.dart';
import 'package:colegio_bnnm/features/school/screens/homework/homework_screen.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/select_chat_screen.dart';
import 'package:colegio_bnnm/features/school/screens/qualifications/qualifications_screen.dart';
import 'package:colegio_bnnm/features/school/screens/select/widgets/container_to_choose.dart';
import 'package:colegio_bnnm/features/school/screens/select/widgets/extra_buttons_group.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerList extends StatefulWidget {
  const ContainerList({super.key, required this.forT});
  final bool forT;

  @override
  State<ContainerList> createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  final controller = SelectController.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.counterSelect.value == 2) {
        final usersOnline = OnlineUserController.instance.usersOnline;
        controller.setUsersOnline(usersOnline, widget.forT);
      }
      return SizedBox(
          height: BHelperFunctions.screenHeight() * .65,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.models.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContainerToChoose(
                          onTap: () => _manejarClic(index),
                          pressed: controller.options[index],
                          forT: widget.forT,
                          model: controller.models[index]),
                      Visibility(
                          visible: controller.options[index] &&
                              controller.selectingOne(),
                          child: const ExtraButtonsGroupContainer(
                              forButton: false)),
                      const SizedBox(height: BSizes.spaceBtwItems)
                    ]);
              }));
    });
  }

  void _manejarClic(int index) {
    setState(() {
      final goToScreen = controller.counterSelect.value == 1;
      if (goToScreen) {
        if (controller.selectAttendance()) {
          // DIRIGIR al Screen de Asistencias
          //
          // INSTANCE CONTROLLER
          final attendanceController = Get.put(AttendanceController());
          // ESTABLECER el id del aula en el Screen de Asistencia
          attendanceController.classroomId.value =
              controller.listClassrooms[index].id;
          controller.counterSelect.value = 2;
          Get.to(() => const AttendanceScreen());
        } else if (controller.selectQualifications()) {
          // DIRIGIR al Screen de Calificaciones
          //
          // INSTANCE CONTROLLER
          final qualificationsController = Get.put(QualificationsController());
          // ESTABLECER el id del estudiante en el Screen de Calificaciones
          final student = controller
              .listClassrooms[controller.indexSelected.value].students[index];
          qualificationsController.studentId = student.id;
          qualificationsController.studentName = student.getName();
          Get.to(() => const QualificationsScreen());
        } else if (controller.selectHomework()) {
          // DIRIGIR al Screen de Tareas
          //
          // INSTANCE CONTROLLER
          final homeworkController = Get.put(HomeworkController());
          homeworkController.classroomId = controller.listClassrooms[index].id;
          homeworkController.studentsTotal =
              controller.listClassrooms[index].students.length;
          Get.to(() => const HomeworkScreen());
        } else if (controller.selectMessageToParents()) {
          // DIRIGIR al Screen de Comunicación (con Apoderados)
          //
          final messagesController = Get.put(SelectChatController());
          messagesController.setStatus(MessagesStatus.selecting);
          final classroomSelected = controller.listClassrooms[index];
          messagesController.extraInfo = classroomSelected.getRoom();
          final groupId = classroomSelected.id;
          messagesController.groupId = groupId;
          messagesController.loadData(classroomSelected.students);
          Get.to(() => SelectChatScreen(forT: widget.forT));
        } else if (controller.selectMessageToTeachers()) {
          // DIRIGIR al Screen de Comunicación (con Docentes)
          //
          final messagesController = Get.put(SelectChatController());
          messagesController.setStatus(MessagesStatus.teachersList);
          final studentSelected = controller.listStudents[index];
          messagesController.extraInfo = studentSelected.reducedName();
          final groupId = studentSelected.id;
          messagesController.groupId = groupId;
          messagesController.loadData(studentSelected.teachers);
          Get.to(() => SelectChatScreen(forT: widget.forT));
        }
      } else {
        if (controller.selectingMany()) {
          // Cuando el Docente está seleccionando varias aulas
          controller.changeState(index);
        } else {
          controller.counterSelect.value -= 1;
          if (!controller.selectQualifications()) {
            _manejarClic(index);
          } else {
            controller.setModels(widget.forT, fromDrawer: false);
          }
        }
      }
    });
  }
}
