import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class UserItemModel {
  UserItemModel(
      {required this.id,
      required this.name,
      required this.lastname,
      this.email,
      this.online = false,
      this.role = Roles.user});
  final int id;
  final String name;
  final String lastname;
  final String? email;
  bool online;
  final Roles role;

  factory UserItemModel.empty() =>
      UserItemModel(id: 0, name: "", lastname: "", email: "");

  void changeStateOnline(bool newValue) {
    online = newValue;
  }

  String getName() => "$name $lastname";
  String getImg() => BImages.user;
  String getText() => role == Roles.user
      ? ""
      : BFormatter.formatName(name, lastname, separated: false);
  String getRoleImg() => BImages.roles(role);
}

class UserForHome {
  final String name;
  final String lastname;
  final Roles role;
  UserForHome(this.name, this.lastname, this.role);
  String getName() => "$name $lastname";
  String getRoleImg() => BImages.roles(role);
  String getText() => role == Roles.user
      ? ""
      : BFormatter.formatName(name, lastname, separated: false);
}
