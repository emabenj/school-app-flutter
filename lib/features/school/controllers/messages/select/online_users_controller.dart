import 'dart:convert';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/group_online_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_online_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/mappers/list_int_mapper.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OnlineUserController extends GetxController {
  static OnlineUserController get instance => Get.find();

  final usersOnline = <GroupOnlineModel>[].obs; // Lista de apoderados en línea
  late WebSocketChannel channel;
  int roleId = AuthenticationRepository.instance.currentUser()!.user.id;

  String nameUserChat = "";
  int? idUserChat;
  final onlineUserChat = false.obs;

  void connectWebSocket() {
    final token = AuthenticationRepository.instance.token();
    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://${APIConstants.domain}ws/chat/online/$roleId/?token=$token'),
    );

    // Escuchar los mensajes del WebSocket
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      // print(decodedMessage);
      final type = decodedMessage['type'];
      const listUsersOnline = ["apoderados", "docentes"];
      const actionsUsers = ["connected", "disconnected"];
      final indexTypeGetUsers =
          listUsersOnline.indexWhere((u) => "${u}_online" == type);
      final indexTypeActionUser =
          actionsUsers.indexWhere((a) => "user_$a" == type);
      // List<GroupOnlineModel> usersOnlineList = [];

      if (indexTypeGetUsers != -1) {
        final groupName = listUsersOnline[indexTypeGetUsers];
        // usersOnlineList =;
        usersOnline.value =
            GroupOnlineListModel.fromJson(decodedMessage[groupName]).list();
      } else if (indexTypeActionUser != -1) {
        final userId = int.parse(decodedMessage['user_id'].toString());
        final actualUserId = AuthenticationRepository.instance.userId();
        if (actualUserId != 0 && userId != actualUserId) {
          final groupsIds = ListIntMapper.toList(decodedMessage['groups_ids']);
          final listCopiedUsersOnline = usersOnline.isNotEmpty
              ? usersOnline.sublist(0)
              : <GroupOnlineModel>[];
          for (var g in listCopiedUsersOnline) {
            (indexTypeActionUser == 0)
                ? g.addUserIfInGroupsIds(userId, groupsIds)
                : g.removeUserIfInGroupsIds(userId, groupsIds);
          }
          
          usersOnline.value = listCopiedUsersOnline;
          usersOnline.refresh();
        }
      }
    });
  }

  List<UserOnlineModel> getUsersOnlineByGroupId(int groupId) {
    final groupModel =
        usersOnline.firstWhereOrNull((group) => group.id == groupId);
    final usersOnlineList =
        groupModel == null ? <UserOnlineModel>[] : groupModel.group;
    return usersOnlineList;
  }

  @override
  void onClose() {
    try {
      channel.sink.close();
    } catch (e) {
      // print("CHANNEL ONLINE USERS");
    }
    super.onClose();
  }
}
