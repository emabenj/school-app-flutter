import 'dart:convert';
import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';

class UserUpdateModel {
    final int id;
    final String email;
    final String phoneNumber;
    final String address;

    UserUpdateModel({
        required this.id,
        required this.email,
        required this.phoneNumber,
        required this.address,
    });

    factory UserUpdateModel.fromRawJson(String str) => UserUpdateModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["telefono"],
        address: json["direccion"],
    );

    factory UserUpdateModel.fromUserAuthenticated(UserAuthenticatedModel model) => UserUpdateModel(
        id: model.user.id,
        email: model.user.email,
        phoneNumber: model.user.phoneNumber,
        address: model.user.address,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "telefono": phoneNumber,
        "direccion": address,
    };
}
