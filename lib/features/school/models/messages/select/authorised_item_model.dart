import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';

class AuthorisedItemModel extends UserItemModel {
  AuthorisedItemModel(
      {required super.id,
      required super.name,
      required super.lastname,
      required super.email,
      super.role = Roles.authorised});

    factory AuthorisedItemModel.fromJson(Map<String, dynamic> json) => AuthorisedItemModel(
        id: json["usuario_id"],
        name: json["nombres"],
        lastname: json["apellidos"],
        email: json["email"],
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "nombres": name,
    //     "apellidos": lastname,
    //     "email": email,
    // };
}

class AuthorisedListModel {
  final List<AuthorisedItemModel> _parents;

  AuthorisedListModel({required List<AuthorisedItemModel> parents}) : _parents = parents;

  factory AuthorisedListModel.fromJson(List<dynamic> json) {
    return AuthorisedListModel(
        parents: json.map((item) => AuthorisedItemModel.fromJson(item)).toList());
  }

  List<AuthorisedItemModel> list() {
    return _parents;
  }
}