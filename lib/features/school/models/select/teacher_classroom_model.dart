import 'package:colegio_bnnm/features/school/models/messages/select/student_item_model.dart';
import 'package:colegio_bnnm/features/school/models/select/classroom_model.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';

class TeacherClassroomModel {
  static String get urlList => "aulas/docente/";
  final ClassroomModel classroom;
  final List<StudentItemModel> students;
  final int parentsTotal;

  int studentsTotal() => students.length;

  TeacherClassroomModel({
    required this.classroom,
    required this.students,
    required this.parentsTotal,
  });

  factory TeacherClassroomModel.fromJson(Map<String, dynamic> json) =>
      TeacherClassroomModel(
        classroom: ClassroomModel.fromJson(json),
        students: StudentItemListModel.fromJson(json["estudiantes"]).list(),
        parentsTotal: json["apoderados"],
      );

  SelectModel select() => SelectModel(
      title: classroom.getRoom(),
      subTitle: "${studentsTotal()} alumnos - $parentsTotal apoderados",
      stateUsers: "");

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
  final List<TeacherClassroomModel> _classrooms;

  ClassroomListModel({required List<TeacherClassroomModel> classrooms})
      : _classrooms = classrooms;

  factory ClassroomListModel.fromJson(List<Map<String, dynamic>> json) {
    return ClassroomListModel(
        classrooms:
            json.map((item) => TeacherClassroomModel.fromJson(item)).toList());
  }

  List<TeacherClassroomModel> list() {
    return _classrooms;
  }
}
