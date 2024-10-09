import 'package:colegio_bnnm/features/authentication/models/login/admin_authenticated_model.dart';
import 'package:colegio_bnnm/features/authentication/models/login/authorised_authenticated_model.dart';
import 'package:colegio_bnnm/features/authentication/models/login/teacher_authenticated_model.dart';
import 'dart:convert';

import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';

class UserAuthenticatedModel {
  final String refreshToken;
  String accessToken;
  final dynamic user;

  UserAuthenticatedModel({
    required this.refreshToken,
    required this.accessToken,
    required this.user,
  });

  Roles get role => BAuthMapper.role(user.role);

  void setNewAccessToken(String newAccessToken) {
    accessToken = newAccessToken;
  }

  static UserAuthenticatedModel empty() => UserAuthenticatedModel(
      refreshToken: "",
      accessToken: "",
      user: CustomUserModel(
          userId: 0,
          id: 0,
          email: "",
          role: "Invitado",
          name: "",
          lastname: ""));

  factory UserAuthenticatedModel.fromRawJson(String str) =>
      UserAuthenticatedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAuthenticatedModel.fromJson(Map<String, dynamic> json) {
    final userAuth = UserModel.fromJson(json["user"]);
    return UserAuthenticatedModel(
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
        user: userAuth.role == "Docente"
            ? TeacherAuthenticatedModel.fromJson(json["user"], userAuth)
            : userAuth.role == "Apoderado"
                ? AuthorisedAuthenticatedModel.fromJson(json["user"], userAuth)
                : userAuth.role == "Administrador"
                    ? AdminAuthenticatedModel.fromJson(json["user"], userAuth)
                    : UserAuthenticatedModel.empty());
  }

  Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class CustomUserModel {
  final int userId;
  final int id;
  String email;
  final String role;
  DateTime? lastProfileUpdated;
  final String name;
  final String lastname;

  CustomUserModel({
    required this.userId,
    required this.id,
    required this.email,
    required this.role,
    this.lastProfileUpdated,
    required this.name,
    required this.lastname,
  });
}

class UserModel extends CustomUserModel {
  UserModel(
      {required super.userId,
      required super.id,
      required super.email,
      required super.role,
      super.lastProfileUpdated,
      required super.name,
      required super.lastname});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["usuario_id"],
        id: json["id"],
        email: json["correo"],
        role: json["rol"],
        lastProfileUpdated: BFormatter.formatStringToDate(json["ultima_actualizacion_perfil"]),
        name: json["nombres"],
        lastname: json["apellidos"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "email": email,
  //       "role": role,
  //       "nombres": name,
  //       "apellidos": lastname,
  //     };
}
