import 'package:colegio_bnnm/features/school/models/messages/select/teacher_item_model.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class StudentRoomModel {
  static String get urlList => "estudiantes/apoderado/";
  final int id;
  final String name;
  final String lastname;
  final int gender;
  final String classroom;
  final List<TeacherItemModel> teachers;

  String reducedName() => BFormatter.reduceName("$name $lastname");

  StudentRoomModel(
      {required this.id,
        required this.name,
      required this.lastname,
      required this.gender,
      required this.classroom,
      required this.teachers});

  factory StudentRoomModel.fromJson(Map<String, dynamic> json) =>
      StudentRoomModel(
        id:json["id"],
        name: json["nombres"],
        lastname: json["apellidos"],
        gender: json["genero"],
        classroom: json["aula_info"],
        teachers: TeacherItemListModel.fromJson(json["docentes"]).list(),
      );
  SelectModel select() =>
      SelectModel(title: reducedName(), subTitle: classroom, stateUsers: "");
}

class StudentRoomListModel {
  final List<StudentRoomModel> _students;

  StudentRoomListModel({required List<StudentRoomModel> students})
      : _students = students;

  factory StudentRoomListModel.fromJson(List<Map<String, dynamic>> json) {
    return StudentRoomListModel(
        students: json.map((item) => StudentRoomModel.fromJson(item)).toList());
  }

  List<StudentRoomModel> list() {
    return _students;
  }
}
