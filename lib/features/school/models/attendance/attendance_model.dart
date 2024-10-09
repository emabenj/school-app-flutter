import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/attendance/attendance_changes_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class AttendanceModel {
  static String get urlList => "asistencias/aula/";
  final int id;
  final int studentId;
  final DateTime date;
  final String name;
  final String lastname;
  final int gender;
  int status;

  AttendanceModel(
      {required this.id,
      required this.studentId,
      required this.date,
      required this.name,
      required this.lastname,
      required this.gender,
      required this.status});

  String get genderImage =>
      ItemListController.instance.gender.value.getImg(gender);
  bool isRetired() =>
      ItemListController.instance.attendance.value.isRetired(status);

  static AttendanceModel empty() => AttendanceModel(
      id: 0,
      studentId: 0,
      date: DateTime.now(),
      name: "",
      lastname: "",
      gender: 0,
      status: 0);

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
          id: json["id"],
          studentId: json["estudiante_id"],
          date: BFormatter.formatStringToDate(json["fecha"])!,
          name: json["nombres"],
          lastname: json["apellidos"],
          gender: json["genero"],
          status: json["estado"]);

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "estudiante_id": studentId,
  //       "fecha": date,
  //       "nombres": name,
  //       "apellidos": lastname,
  //       "genero": gender,
  //       "estado": status,
  //     };
  AttendanceChangesModel toChange() =>
      AttendanceChangesModel(attendanceId: id, status: status);

  bool pressed = false;

  void changeStatus(int id) {
    status = id;
  }

  void changeToAttendend() {
    status = ItemListController.instance.attendance.value.mapper.getModelByEnum(AttendanceStatus.attended).id;
  }
}

class AttendanceListModel {
  final List<AttendanceModel> _attendances;

  AttendanceListModel({required List<AttendanceModel> attendances})
      : _attendances = attendances;

  factory AttendanceListModel.fromJson(List<Map<String, dynamic>> json) {
    return AttendanceListModel(
        attendances:
            json.map((item) => AttendanceModel.fromJson(item)).toList());
  }

  List<AttendanceModel> list() {
    return _attendances;
  }

  List<dynamic> listChange() {
    return _attendances.map((e) => e.toChange().toJson()).toList();
  }
}
