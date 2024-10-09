import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class TeacherAuthenticatedModel extends CustomUserModel {
  String phoneNumber;
  String address;
  final String gender;
  final DateTime? dateBirth;
  final CourseModel course;

  TeacherAuthenticatedModel({
    required super.userId,
    required super.id,
    required super.email,
    required super.role,
    required super.lastProfileUpdated,
    required super.name,
    required super.lastname,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.dateBirth,
    required this.course,
  });

  void updateEmail(String newEmail) {
    email = newEmail;
  }

  void updateAddress(String newAddress) {
    address = newAddress;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
  }

  void updateAllowToUpdate(DateTime date) {
    lastProfileUpdated = date;
  }

  factory TeacherAuthenticatedModel.fromJson(
          Map<String, dynamic> json, UserModel user) =>
      TeacherAuthenticatedModel(
          userId: user.userId,
          id: user.id,
          email: user.email,
          role: user.role,
          lastProfileUpdated: user.lastProfileUpdated,
          name: user.name,
          lastname: user.lastname,
          phoneNumber: json["telefono"],
          address: json["direccion"],
          gender: json["genero"],
          dateBirth: BFormatter.formatStringToDate(json["fecha_nacimiento"]),
          course: CourseModel.fromJson(json["curso"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role": role,
        "nombres": name,
        "apellidos": lastname,
        "telefono": phoneNumber,
        "direccion": address,
        "genero": gender,
        "fecha_nacimiento": BFormatter.formatDateToString(dateBirth),
        "curso": course.toJson()
      };
}
