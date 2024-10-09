import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';

class AdminAuthenticatedModel extends CustomUserModel {

  AdminAuthenticatedModel(
      {required super.userId,
    required super.id,
    required super.email,
    required super.role,
    required super.name,
    required super.lastname,
  });

  factory AdminAuthenticatedModel.fromJson(
          Map<String, dynamic> json, UserModel user) =>
      AdminAuthenticatedModel(
        userId: user.userId,
        id: user.id,
        email: user.email,
        name: user.name,
        lastname: user.lastname,
        role: user.role
      );
}
