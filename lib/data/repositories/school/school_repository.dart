import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/services/school/school_service.dart';
import 'package:colegio_bnnm/features/school/controllers/attendance/attendance_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/attendance/attendance_model.dart';
import 'package:colegio_bnnm/features/school/models/homework/homework_model.dart';
import 'package:colegio_bnnm/features/school/models/homework/homework_register_model.dart';
import 'package:colegio_bnnm/features/school/models/homework/homework_edit_model.dart';
import 'package:colegio_bnnm/features/school/models/new/new_edit_model.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/models/new/new_register_model.dart';
import 'package:colegio_bnnm/features/school/models/qualifications/qualifications_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/authorised_register_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/student_register_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/teacher_register_model.dart';
import 'package:colegio_bnnm/features/school/models/select/classroom_model.dart';
import 'package:colegio_bnnm/features/school/models/select/student_room_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SchoolRepository extends GetxController {
  static SchoolRepository get instance => Get.find();
  final _navController = NavigationController.instance;
  final _authRepository = AuthenticationRepository.instance;
  // VARIABLES
  final _school = SchoolService();

  // ADMINISTRADOR
  Future<NewModel> addNew(
      String title, String content, int category, XFile? img) async {
    final adminId = _authRepository.roleId();
    final newInsert = NewRegisterModel(
        title: title, content: content, category: category, admin: adminId);
    final newCreated = await _school
        .addModel(NewRegisterModel.url, newInsert.toJson(), img: img);
    return newCreated as NewModel;
  }

  Future<NewModel> editNew(int id, String title, String content, int category,
      int admin, String? img, XFile? imgUpdate) async {
    final newEdit = NewEditModel(
      title: title,
      img: img,
      content: content,
      category: category,
    );

    return img == null
        ? await _school.editModel(NewModel.url, id, newEdit.toJson(),
            img: imgUpdate)
        : await _school.editModel(NewModel.url, id, newEdit.toJson());
  }

  Future<void> deleteNew(int id) async {
    await _school.deleteModel(NewModel.url, id);
  }

  Future<StudentRegisterModel> getStudent(String dni) async {
    final student = await _school.getStudentByDni(dni);
    return student;
  }

  Future<String> registerAuthorised(String name, String lastName, String email,
      String phoneNumber, String address, List<int> idStudentList) async {
    final authorisedRegister = AuthorisedRegisterModel(
        name: name,
        lastname: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        students: idStudentList);
    return await _school.registerAccount(
        authorisedRegister, AuthorisedRegisterModel.urlRegister);
  }

  Future<String> registerTeacher(
      String name,
      String lastName,
      String email,
      String phoneNumber,
      String address,
      int gender,
      String dateBirth,
      int course) async {
    final teacherRegister = TeacherRegisterModel(
        name: name,
        lastname: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        gender: gender,
        dateBirth: dateBirth,
        course: course);

    return await _school.registerAccount(
        teacherRegister, TeacherRegisterModel.urlRegister);
  }

  //
  // TEACHER
  //
  Future<List<ClassroomModel>> getClassroomsByTeacherId() async {
    final teacherId = _authRepository.currentUser()!.user.id;
    final urlList = "${ClassroomModel.urlList}$teacherId/";
    final classrooms =
        await _school.getList(urlList, withToken: true) as List<ClassroomModel>;
    return classrooms;
  }

  Future<List<AttendanceModel>> getAttendancesByClassroomId(
      int classroomId) async {
    final urlList = "${AttendanceModel.urlList}$classroomId";
    final attendances = await _school.getList(urlList, withToken: true)
        as List<AttendanceModel>;
    return attendances;
  }

  Future<String> updateStudentAttendance(
      List<AttendanceModel> attendances) async {
    final classroomId = AttendanceController.instance.classroomId.value;
    final attendancesUpdate =
        AttendanceListModel(attendances: attendances).listChange();
    final urlUpdate = AttendanceModel.urlList;
    return await _school.editModels(urlUpdate, classroomId, attendancesUpdate);
  }

  // QUALIFICATIONS
  Future<QualificationsModel> getQualifications(int studentId) async {
    final qualifications = await _school.getStudentQualifications(studentId);
    return qualifications;
  }

  Future<String> updateQualifications(
      int id,
      double qualification1,
      double qualification2,
      double qualification3,
      double qualification4) async {
    final qualificationsEdit = QualificationsModel(
        id: id,
        qualification1: qualification1,
        qualification2: qualification2,
        qualification3: qualification3,
        qualification4: qualification4);
    final urlEdit = QualificationsModel.url;
    // final response =
    await _school.editModel(urlEdit, id, qualificationsEdit);
    return "Calificaciones actualizadas correctamente";
  }

  //HOMEWORK
  Future<List<HomeworkModel>> getHomeworkByClassroom(int classroomId) async {
    if (_navController.isTeacher()) {
      final teacherId = _authRepository.currentUser()!.user.id;
      final urlList =
          "${HomeworkModel.urlList}?docente=$teacherId&aula=$classroomId";
      final homeworks = await _school.getList(urlList, withToken: true)
          as List<HomeworkModel>;
      return homeworks;
    } else {
      throw Exception("Solo el docente puede buscar sus tareas");
    }
  }

  Future<HomeworkModel> addHomework(
      int classroomId, String description, String dueDate) async {
    if (_navController.isTeacher()) {
      final teacherId = _authRepository.roleId();
      final urlAdd = HomeworkModel.urlList;
      final homeworkModel = HomeworkRegisterModel(
          classroomId: classroomId,
          teacherId: teacherId,
          description: description,
          dueDate: dueDate,
          status: ItemListController.instance.homework.value.mapper
              .getModelByEnum(HomeworkStatus.underRevision)
              .id);
      final response = await _school.addModel(urlAdd, homeworkModel);
      return response;
    } else {
      throw Exception("Solo el docente puede buscar sus tareas");
    }
  }

  Future<HomeworkModel> editHomework(
      int id, String description, String dueDate) async {
    if (_navController.isTeacher()) {
      final urlAction = HomeworkModel.urlList;
      final homeworkEdit =
          HomeworkEditModel(description: description, dueDate: dueDate);
      final response = await _school.editModel(urlAction, id, homeworkEdit);
      return response;
    } else {
      throw Exception("Solo el docente puede buscar sus tareas");
    }
  }

  Future<String> deleteHomework(int homeworkId) async {
    if (_navController.isTeacher()) {
      final urlDelete = HomeworkModel.urlList;
      await _school.deleteModel(urlDelete, homeworkId);
      return "Tarea elimnada";
    } else {
      throw Exception("Solo el docente puede eliminar una tarea.");
    }
  }

  //
  // AUTHORISED
  //
  Future<List<StudentRoomModel>> getStudentsByAuthorisedId() async {
    final authorisedId = _authRepository.roleId();
    final urlList = "${StudentRoomModel.urlList}$authorisedId/";
    final students = await _school.getList(urlList, withToken: true)
        as List<StudentRoomModel>;
    return students;
  }

  Future<NewModel> getNewById(NewModel model) async {
    final deviceStorage = GetStorage();
    final userId = _authRepository.userId();
    final key = "new-${model.id}-user-$userId";
    return deviceStorage.read(key) != true
        ? await _school.getNewById(model.id)
        : model;
  }
}
