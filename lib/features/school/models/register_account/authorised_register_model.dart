import 'package:colegio_bnnm/features/school/models/register_account/custom_user_register_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';

class AuthorisedRegisterModel extends CustomUserRegisterModel {
  static String get urlRegister => BAuthMapper.urlRole(Roles.authorised, inSingular: true);
  final List<int> students;

  AuthorisedRegisterModel({
    required super.name,
    required super.lastname,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required this.students,
  });
  factory AuthorisedRegisterModel.fromJson(Map<String, dynamic> json) =>
      AuthorisedRegisterModel(
        name: json["nombres"],
        lastname: json["apellidos"],
        phoneNumber: json["telefono"],
        address: json["direccion"],
        email: json["email"],
        students: List<int>.from(json["estudiantes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nombres": name,
        "apellidos": lastname,
        "telefono": phoneNumber,
        "direccion": address,
        "email": email,
        "estudiantes": List<dynamic>.from(students.map((x) => x)),
      };
}
