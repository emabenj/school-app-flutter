import 'package:colegio_bnnm/features/school/models/register_account/custom_user_register_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';

class TeacherRegisterModel extends CustomUserRegisterModel {
  static String get urlRegister => BAuthMapper.urlRole(Roles.teacher, inSingular: true);
  final int gender;
  final String dateBirth;
  final int course;

  TeacherRegisterModel({
    required super.name,
    required super.lastname,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required this.gender,
    required this.dateBirth,
    required this.course,
  });

  factory TeacherRegisterModel.fromJson(Map<String, dynamic> json) =>
      TeacherRegisterModel(
        name: json["nombres"],
        lastname: json["apellidos"],
        phoneNumber: json["telefono"],
        address: json["direccion"],
        email: json["email"],
        gender: json["genero"],
        dateBirth: json["fecha_nacimiento"],
        course: json["curso"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": name,
        "apellidos": lastname,
        "telefono": phoneNumber,
        "direccion": address,
        "email": email,
        "genero": gender,
        "fecha_nacimiento": dateBirth,
        "curso": course,
      };
}
