import 'package:colegio_bnnm/util/formatters/formatter.dart';

class StudentRegisterModel {
  static String get url => "estudiantes/";
  final int id;
  final String name;
  final String lastname;
  final String dni;
  // final int? gender;
  // final int? room;
  
  String get fullName => BFormatter.formatName(name, lastname, separated: false);
  StudentRegisterModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.dni,
    // required this.gender,
    // required this.room
  });

  factory StudentRegisterModel.fromJson(Map<String, dynamic> json) =>
      StudentRegisterModel(
        id: json["id"],
        name: json["nombres"],
        lastname: json["apellidos"],
          dni: json["dni"],
        //   gender: json["genero"],
        //   room: json["aula"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": name,
        "apellidos": lastname,
        "dni": dni,
        // "genero": gender,
        // "aula": room,
      };
}

// class StudentRegisterListModel {
//   final List<StudentRegisterModel> _students;

//   StudentRegisterListModel({required List<StudentRegisterModel> students})
//       : _students = students;

//   factory StudentRegisterListModel.fromJson(List<Map<String, dynamic>> json) {
//     return StudentRegisterListModel(
//         students:
//             json.map((item) => StudentRegisterModel.fromJson(item)).toList());
//   }

//   List<StudentRegisterModel> list() {
//     return _students;
//   }
// }
