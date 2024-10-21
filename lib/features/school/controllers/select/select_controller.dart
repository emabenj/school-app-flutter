import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/group_online_model.dart';
import 'package:colegio_bnnm/features/school/models/select/teacher_classroom_model.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';
import 'package:colegio_bnnm/features/school/models/select/student_room_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:get/get.dart';

class SelectController extends GetxController {
  static SelectController get instance => Get.find();
  final onlineUsersController = Get.put(OnlineUserController());
  final navController = NavigationController.instance;
  // final userId = 0.obs;
  //VARIABLES
  final counterSelect = 2.obs;

  Future<void> loadData() async {
    final roomsIds = <int>[];
    await AuthenticationRepository.instance.responseValidatorControllers(
        () async {
      if (navController.isTeacher()) {
        //
        // CLASSROOMS
        //
        listClassrooms.value =
            await SchoolRepository.instance.getClassroomsByTeacherId();
        // INSERT IDS
        roomsIds.addAll(listClassrooms.map((c) => c.classroom.id));
        // CLASSROOMS TO SELECT
        listToSelect.value = listClassrooms.map((e) => e.select()).toList();
      } else if (navController.isAuthorised()) {
        //
        // STUDENTS
        //
        listStudents.value =
            await SchoolRepository.instance.getStudentsByAuthorisedId();
        // INSERT IDS
        roomsIds.addAll(listStudents.map((c) => c.classroom.id));
        // STUDENTS TO SELECT
        listToSelect.value = listStudents.map((e) => e.select()).toList();
      }
    },
        back: true,
        titleMessage:
            "Error al obtener información de ${navController.isTeacher() ? 'las aulas' : 'los estudiantes'}");

    // Obtener usuarios conectados
    onlineUsersController.roomsIds = roomsIds;
    onlineUsersController.connectSockets();
  }

  // LISTS OF TEACHER (classrooms)
  final listClassrooms = <TeacherClassroomModel>[].obs;
  // LIST STUDENTS (from Room, from Authorised)
  final listStudents = <StudentRoomModel>[].obs;
  // LIST OF ITEMS TO SELECT (Rooms, Students)
  final listToSelect = <SelectModel>[].obs;

  // VARIABLES
  final models = <SelectModel>[].obs;

  // final totalOptions = 0.obs;

  // LIST CONTAINERS - save the states when each container is pressed
  final options = RxList<bool>([]);
  // INDEX SELECTED - Save selected index to remove when another one is selected in ROOM status
  final indexSelected = 0.obs;

  // BUTTON GROUP
  final Rx<bool> buttonPressed = Rx<bool>(false);
  final Rx<bool> showExtra = Rx<bool>(false);
  final Rx<List<int>> selectedIndexes = Rx<List<int>>([]);

  //CONSTANTS
  static const heightContainer = BSizes.iconContainer + BSizes.sm * 2;
  final heightExtraMd = BSizes.iconButtonMd + BSizes.sm * 2;
  final heightExtraLg = BSizes.iconButtonLg + BSizes.sm * 2;

  void setModels(bool forT, {bool fromDrawer = true}) {
    if (fromDrawer) {
      listToSelect.value = forT
          ? listClassrooms.map((e) => e.select()).toList()
          : listStudents.map((e) => e.select()).toList();
      models.value = listToSelect;
    } else {
      if (forT) {
        listToSelect.value =
            listClassrooms[indexSelected.value].selectStudents();
      }
      models.value = !forT && selectMessageToTeachers()
          ? listToSelect
          : selectQualifications()
              ? listToSelect
              : listToSelect;
    }
    // SET TOTAL OPTIONS or CONTAINERS TO SELECT
    options.value = List.generate(models.length, (_) => false);
    // RESTART VALUES FOR SELECTED INDEXES AND STATE OF EXTRA CONTAINER OF THE BUTTON
    _removeAll();
  }

  void setUsersOnline(List<GroupOnlineModel> groups, bool forT) {
    final onlineTotal = groups.isNotEmpty
        ? groups.map((e) => e.usersOnline.length).toList()
        : List.generate(models.length, (index) => 0);
    final totalList = forT
        ? listClassrooms.map((room) => room.parentsTotal).toList()
        : listStudents.map((student) => student.teachers.length).toList();

    for (var i = 0; i < models.length; i++) {
      final groupNameP = forT ? "apoderados" : "docentes";
      final state = onlineTotal[i] == 0
          ? "No hay $groupNameP conectados"
          : onlineTotal[i] == totalList[i]
              ? "Todos los $groupNameP en línea"
              : "${onlineTotal[i]} / ${totalList[i]} $groupNameP en línea";
      models[i].stateUsers = state;
    }
    models.refresh();
  }

  void changeState(int index) {
    options[index] = !options[index];
    // RESTORE THE CONTAINER SELECTED
    if (selectingOne()) {
      options[indexSelected.value] =
          indexSelected.value != index ? false : options[index];
    } else if (selectingMany()) {
      options[index] ? _insertIndex(index) : _removeIndex(index);
      showExtra.value = selectedIndexes.value.length > 1;
    }
    indexSelected.value = index;
  }

  final Rx<StatusSelection> _state = Rx<StatusSelection>(StatusSelection.room);

  void changeButtonState() {
    buttonPressed.value = !buttonPressed.value;
    setState(
        buttonPressed.value ? StatusSelection.rooms : StatusSelection.room);

    _removeAll(); // CLEAN LIST OF SELECTED INDEXES
  }

  void _insertIndex(int index) {
    selectedIndexes.value.add(index);
  }

  void _removeAll() {
    selectedIndexes.value.clear();
    showExtra.value = false;
  }

  void _removeIndex(int index) {
    selectedIndexes.value.remove(index);
  }

  StatusSelection getState() {
    return _state.value;
  }

  void setState(StatusSelection state, {bool fromDrawer = false}) {
    _state.value = state;
    // if (selectHomework()) {
    //   Get.to(() => const HomeworkScreen());
    //   return;
    // }
    setModels(!(selectMessageToTeachers() || selectingStudent()),
        fromDrawer: fromDrawer);
  }

  static List<StatusSelection> actions = [
    StatusSelection.messagesToParents,
    StatusSelection.selHomework,
    StatusSelection.selQualifications
  ];

  // VALIDATIONS
  bool selectingMany() {
    return getState() == StatusSelection.rooms;
  }

  bool selectingOne() {
    return getState() == StatusSelection.room;
  }

  bool selectingRoom() {
    return selectingMany() || selectingOne();
  }

  bool selectingStudent() {
    return getState() == StatusSelection.student;
  }

  bool selectAttendance() {
    return getState() == StatusSelection.selAttendance;
  }

  bool selectQualifications() {
    return getState() == StatusSelection.selQualifications;
  }

  bool selectHomework() {
    return getState() == StatusSelection.selHomework;
  }

  bool selectMessageToTeachers() {
    return getState() == StatusSelection.messagesToTeachers;
  }

  bool selectMessageToParents() {
    return getState() == StatusSelection.messagesToParents;
  }
}
