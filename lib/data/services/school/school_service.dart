import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/models/attendance/attendance_model.dart';
import 'package:colegio_bnnm/features/school/models/homework/homework_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/attendance_status_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/category_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/gender_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/homework_status_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/level_model.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/models/qualifications/qualifications_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/student_register_model.dart';
import 'package:colegio_bnnm/features/school/models/select/classroom_model.dart';
import 'package:colegio_bnnm/features/school/models/select/student_room_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/http/http_client.dart';
import 'package:colegio_bnnm/util/http/message_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SchoolService {
  static String schoolUrl = APIConstants.schoolUrl;
  final authRepository = AuthenticationRepository.instance;

  Future<List<dynamic>> getList(String url, {bool withToken = false}) async {
    return await authRepository.responseValidatorServices(() async {
      final token = withToken ? authRepository.token() : "";
      final urlList = "$schoolUrl$url";
      final response =
          await BHttpHelper.get(urlList, token: token, isList: true);
      if (url == CategoryModel.url) {
        return CategoryListModel.fromJson(response).list();
      } else if (url == GenderModel.url) {
        return GenderListModel.fromJson(response).list();
      } else if (url == LevelModel.url) {
        return LevelListModel.fromJson(response).list();
      } else if (url == CourseModel.url) {
        return CourseListModel.fromJson(response).list();
      } else if (url == NewModel.url) {
        return NewListModel.fromJson(response).list();
      } else if (url == AttendanceStatusModel.url) {
        return AttendanceStatusListModel.fromJson(response).list();
      } else if (url == HomeworkStatusModel.url) {
        return HomeworkStatusListModel.fromJson(response).list();
        //
        // With query params
        //
      } else if (url.contains(AttendanceModel.urlList)) {
        return AttendanceListModel.fromJson(response).list();
      } else if (url.contains(ClassroomModel.urlList)) {
        return ClassroomListModel.fromJson(response).list();
      } else if (url.contains(StudentRoomModel.urlList)) {
        return StudentRoomListModel.fromJson(response).list();
      } else if (url.contains(HomeworkModel.urlList)) {
        return HomeworkListModel.fromJson(response).list();
      } else {
        return [];
      }
    });
  }

  Future<NewModel> getNewById(int id) async {
    final deviceStorage = GetStorage();
    final userId = authRepository.userId();
    final key = "new-$id-user-$userId";
    deviceStorage.writeIfNull(key, true);
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final nameUrl = "$schoolUrl${NewModel.url}$id/";
      final response = await BHttpHelper.get(nameUrl, token: token);
      return NewModel.fromJson(response);
    });
  }

  // HomeworkStatusModel.url,
  //41561651
  Future<StudentRegisterModel> getStudentByDni(String dni) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final nameUrl = "$schoolUrl${StudentRegisterModel.url}?dni=$dni";
      final response = await BHttpHelper.get(nameUrl, token: token);
      return StudentRegisterModel.fromJson(response);
    });
  }

  Future<QualificationsModel> getStudentQualifications(int studentId) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      if (NavigationController.instance.isTeacher()) {
        // OBTENER el id del curso del docente authenticado
        final courseId = authRepository.currentUser()!.user.course.id;
        final nameUrl =
            "$schoolUrl${QualificationsModel.url}?curso=$courseId&estudiante=$studentId";
        final response = await BHttpHelper.get(nameUrl, token: token);
        return QualificationsModel.fromJson(response);
      } else {
        throw Exception(
            "Solo el docente puede buscar la calificación de un estudiante");
      }
    });
  }

  Future<dynamic> addModel(String url, dynamic model, {XFile? img}) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final urlInsert = "$schoolUrl$url";
      final response =
          await BHttpHelper.post(urlInsert, model, token: token, img: img);
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else if (url == NewModel.url) {
        return NewModel.fromJson(response);
      } else if (url == HomeworkModel.urlList) {
        return HomeworkModel.fromJson(response);
      } else {}
    });
  }

  Future<dynamic> editModel(String url, int id, dynamic model,
      {XFile? img}) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final urlEdit = "$schoolUrl$url$id/";
      final response = await BHttpHelper.patch(urlEdit, model, token: token);
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else if (url == NewModel.url) {
        return NewModel.fromJson(response);
      } else if (url == HomeworkModel.urlList) {
        return HomeworkModel.fromJson(response);
      } else {}
    });
  }

  Future<dynamic> editModels(String url, int id, List<dynamic> models) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final urlEdit = "$schoolUrl$url$id/";
      final response = await BHttpHelper.patch(urlEdit, models,
          token: token); // CHANGE MAYBE
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      }
      if (url == NewModel.url) {
        return NewModel.fromJson(response);
      } else {}
    });
  }

  Future<dynamic> deleteModel(String url, int id) async {
    return await authRepository.responseValidatorServices(() async {
      final token = authRepository.token();
      final urlDelete = "$schoolUrl$url$id/";
      await BHttpHelper.delete(urlDelete, token: token);
    });
  }

  Future<String> registerAccount(dynamic model, String url) async {
    return await authRepository.responseValidatorServices(() async {
      //TOKEN
      final token = authRepository.token();
      // URL
      final urlRegister = "registro/$url";
      final response = await BHttpHelper.post(urlRegister, model, token: token);
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else {
        return "Correo enviado";
      }
    });
  }
}
