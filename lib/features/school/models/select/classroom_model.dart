import 'package:colegio_bnnm/features/school/models/messages/select/student_item_model.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';

class ClassroomModel {
  static String get urlList => "aulas/docente/";
  final int id;
  final String name;
  final String grade;
  final String section;
  final List<StudentItemModel> students;
  final int parentsTotal;

  int studentsTotal() => students.length;
  String getRoom() => "$grade '$section'";

  ClassroomModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.section,
    required this.students,
    required this.parentsTotal,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json["id"],
        name: json["nombre"],
        grade: json["grado"],
        section: json["seccion"],
        students: StudentItemListModel.fromJson(json["estudiantes"]).list(),
        parentsTotal: json["apoderados"],
      );

  SelectModel select() => SelectModel(title: getRoom(),
      subTitle: "${studentsTotal()} alumnos - $parentsTotal apoderados", stateUsers: "");
      
  List<SelectModel> selectStudents() =>
      students.map((e) => e.select()).toList();

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "nombre": name,
  //       "grado": grade,
  //       "seccion": section,
  //       "estudiantes": List<dynamic>.from(students.map((x) => x.toJson())),
  //       "apoderados": parentsTotal,
  //     };
}

class ClassroomListModel {
  final List<ClassroomModel> _classrooms;

  ClassroomListModel({required List<ClassroomModel> classrooms})
      : _classrooms = classrooms;

  factory ClassroomListModel.fromJson(List<Map<String, dynamic>> json) {
    return ClassroomListModel(
        classrooms: json.map((item) => ClassroomModel.fromJson(item)).toList());
  }

  List<ClassroomModel> list() {
    return _classrooms;
  }
}
