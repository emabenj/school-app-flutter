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

  List<UserOnlineModel> list() {
    return _users;
  }
}
