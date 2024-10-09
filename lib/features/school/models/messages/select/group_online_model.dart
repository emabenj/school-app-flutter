import 'package:colegio_bnnm/features/school/models/messages/select/user_online_model.dart';
import 'package:get/get.dart';

class GroupOnlineModel {
  final int id;
  final List<UserOnlineModel> group;
  GroupOnlineModel({required this.id, required this.group});

  factory GroupOnlineModel.fromJson(Map<String, dynamic> json) =>
      GroupOnlineModel(
        id: json.containsKey("aula") ? json["aula"] : json["estudiante"],
        group: json.containsKey("apoderados")
            ? UserOnlineListModel.fromJson(json["apoderados"]).list()
            : UserOnlineListModel.fromJson(json["docentes"]).list(),
      );

  // Método para agregar un usuario si su ID está en groupsIds
  void addUserIfInGroupsIds(int userId, List<int> groupsIds) {
    if (groupsIds.contains(id)) {
      group.addIf(
          group.firstWhereOrNull((u) => u.id == userId) == null,
          UserOnlineModel(id: userId));
    }
  }

  // Método para agregar un usuario si su ID está en groupsIds
  void removeUserIfInGroupsIds(int userId, List<int> groupsIds) {
    if (groupsIds.contains(id)) {
      group.removeWhere((user) => user.id == userId);
    }
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
