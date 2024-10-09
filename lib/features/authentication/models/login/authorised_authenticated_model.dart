import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';

class AuthorisedAuthenticatedModel extends CustomUserModel {
  String phoneNumber;
  String address;
  // final List<StudenModel> students;

  AuthorisedAuthenticatedModel(
      {required super.userId,
    required this.phoneNumber,
    required this.address,
    // required this.students,
    required super.id,
    required super.email,
    required super.role,
    required super.lastProfileUpdated,
    required super.name,
    required super.lastname,
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

  factory AuthorisedAuthenticatedModel.fromJson(
          Map<String, dynamic> json, UserModel user) =>
      AuthorisedAuthenticatedModel(
        userId: user.userId,
        id: user.id,
        email: user.email,
        name: user.name,
        lastname: user.lastname,
        role: user.role,
        lastProfileUpdated: user.lastProfileUpdated,
        phoneNumber: json["telefono"],
        address: json["direccion"],
        // students: json["estudiantes"]
      );


}
