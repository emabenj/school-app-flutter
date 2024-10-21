import 'package:colegio_bnnm/features/school/models/messages/select/user_online_model.dart';
import 'package:get/get.dart';

class GroupOnlineModel {
  final int roomId;
  final List<UserOnlineModel> usersOnline;
  GroupOnlineModel({required this.roomId, required this.usersOnline});

  factory GroupOnlineModel.fromJson(Map<String, dynamic> json) =>
      GroupOnlineModel(
        roomId: json.containsKey("aula") ? json["aula"] : json["estudiante"],
        usersOnline: json.containsKey("apoderados")
            ? UserOnlineListModel.fromJson(json["apoderados"]).list()
            : UserOnlineListModel.fromJson(json["docentes"]).list(),
      );

  void addUserConnected(int userId) {
      usersOnline.addIf(
          usersOnline.firstWhereOrNull((u) => u.id == userId) == null,
          UserOnlineModel(id: userId));
  }

  void removeUserDisconnected(int userId) {
      usersOnline.removeWhere((user) => user.id == userId);
  }
}

class GroupOnlineListModel {
  final List<GroupOnlineModel> _groups;

  GroupOnlineListModel({required List<GroupOnlineModel> groups})
      : _groups = groups;

  factory GroupOnlineListModel.fromJson(List<dynamic> json) {
    return GroupOnlineListModel(
        groups: json.map((item) => GroupOnlineModel.fromJson(item)).toList());
  }

  List<GroupOnlineModel> list() {
    return _groups;
  }
}
