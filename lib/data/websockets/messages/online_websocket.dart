import 'dart:convert';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/group_online_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_online_model.dart';
import 'package:colegio_bnnm/util/websocket/websocket_connection.dart';

class OnlineUsersWebSocket {

  final _channelHelper = BWebSocketConnection();

  void connect(List<int> roomsIds) {
  final controller = OnlineUserController.instance;
    if (roomsIds.isNotEmpty) {
      final totalIds = roomsIds.length;
      final endpoints = List.generate(
          totalIds, (index) => "ws/chat/online/${roomsIds[index]}/");

      final List<void Function(dynamic)> onDatas = List.generate(
          totalIds,
          (index) => (message) {
                final roomId = roomsIds[index];
                final decodedMessage = jsonDecode(message);
                final type = decodedMessage['type'];
                final typeUsersOnline = "online_aula_$roomId";
                const actionsUsers = ["connected", "disconnected"];
                final indexTypeActionUser =
                    actionsUsers.indexWhere((a) => "user_$a" == type);

                if (typeUsersOnline == type) {
                  const groupName = "users_online";
                  final userOnlineList =
                      UserOnlineListModel.fromIntList(decodedMessage[groupName])
                          .list();
                  final group = GroupOnlineModel(
                      roomId: roomId, usersOnline: userOnlineList);
                  controller.usersOnline.add(group);
                } else if (indexTypeActionUser != -1) {
                  final userId =
                      int.parse(decodedMessage['user_id'].toString());

                  final actualUserId =
                      AuthenticationRepository.instance.userId();
                  if (actualUserId != 0 && userId != actualUserId) {
                    final listCopiedUsersOnline = controller.usersOnline.isNotEmpty
                        ? controller.usersOnline.sublist(0)
                        : <GroupOnlineModel>[];
                    for (var g in listCopiedUsersOnline) {
                      (indexTypeActionUser == 0)
                          ? g.addUserConnected(userId)
                          : g.removeUserDisconnected(userId);
                    }

                    controller.usersOnline.value =
                        listCopiedUsersOnline;
                    controller.usersOnline.refresh();
                  }
                }
              });

      _channelHelper.createNewConnections(endpoints, onDatas);
    }
  }


  void disconnect() {
    _channelHelper.disconnectChannels();
  }
}
