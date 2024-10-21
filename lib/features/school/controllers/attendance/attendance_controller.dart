import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/attendance/attendance_model.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  static AttendanceController get instance => Get.find();
  final _authRepository = AuthenticationRepository.instance;
  final _schoolRepository = SchoolRepository.instance;

  final classroomId = 0.obs;

  Future<void> loadData() async {
    await _authRepository.responseValidatorControllers(() async {
      final attendanceList = await _schoolRepository
          .getAttendancesByClassroomId(classroomId.value);
      setModels(attendanceList);
    }, titleMessage: "Error al obtener las asistencias", back: true);
  }

  // VARIABLES
  final models = Rx<List<AttendanceModel>>([]);
  final isPressedList = RxList<bool>([]);

  final attendancesToSelect =
      ItemListController.instance.attendance.value.listAttendanceToSelect();
  //
  //
  //
  void setModels(List<AttendanceModel> newModels) {
    models.value = newModels;
    isPressedList.value = List.generate(models.value.length, (index) => false);
  }

  void changeStatusPressed(int index) {
    isPressedList[index] = !isPressedList[index];
  }

  bool getStatusPressed(int index) {
    return isPressedList[index];
  }

  void selectAll() {
    final newList = models.value.map((e) {
      if (!e.isRetired()) {
        e.changeToAttendend();
      }
      return e;
    }).toList();
    isPressedList.value = List.generate(models.value.length, (index) => false);
    models.value = newList;
  }

  // SAVE
  Future<void> saveChanges() async {
    await _authRepository.responseValidatorControllers(() async {
      // START LOADING
      BFullScreenLoader.openLoadingDialog(
          'Guardando notas...', BImages.loadingAttendance);
      // INFO TO SAVE
      await _schoolRepository.updateStudentAttendance(models.value);
      BFullScreenLoader.stopLoading();
      Get.back();
      BLoaders.successSnackBar(
          title: 'Éxito', message: "Las notas se guardaron correctamente");
    }, fullScreenLoader: true, titleMessage: "Error al guardar cambios");
  }
}
