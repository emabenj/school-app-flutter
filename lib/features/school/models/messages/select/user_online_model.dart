import 'package:colegio_bnnm/util/mappers/list_int_mapper.dart';

class UserOnlineModel {
  final int id;
  // final String email;
  UserOnlineModel({required this.id});

  factory UserOnlineModel.fromJson(Map<String, dynamic> json) =>
      UserOnlineModel(
        id: json["id"],
        // email: json["email"],
      );
}

class UserOnlineListModel {
  final List<UserOnlineModel> _users;

  UserOnlineListModel({required List<UserOnlineModel> users}) : _users = users;

  factory UserOnlineListModel.fromJson(List<dynamic> json) {
    return UserOnlineListModel(
        users: json.map((item) => UserOnlineModel.fromJson(item)).toList());
  }
  factory UserOnlineListModel.fromIntList(List<dynamic> json) {
    final listIds = ListIntMapper.toList(json);
    return UserOnlineListModel(
        users: listIds.map((item) => UserOnlineModel(id: item)).toList());
  }

  List<UserOnlineModel> list() {
    return _users;
  }
}
