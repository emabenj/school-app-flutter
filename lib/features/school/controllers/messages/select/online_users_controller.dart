import 'package:colegio_bnnm/data/websockets/messages/online_websocket.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/group_online_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_online_model.dart';
import 'package:get/get.dart';

class OnlineUserController extends GetxController {
  static OnlineUserController get instance => Get.find();

  final usersOnline = <GroupOnlineModel>[].obs; // Lista de apoderados en línea

  List<int> roomsIds = [];
  final _channelHelper = OnlineUsersWebSocket();

  String nameUserChat = "";
  int? idUserChat;
  final onlineUserChat = false.obs;

  void connectSockets() {
    _channelHelper.connect(roomsIds);
  }

  void disconnectSockets() {
    _channelHelper.disconnect();
  }

  List<UserOnlineModel> getUsersOnlineByRoomId(int roomId) {
    final groupModel =
        usersOnline.firstWhereOrNull((group) => group.roomId == roomId);
    final usersOnlineList =
        groupModel == null ? <UserOnlineModel>[] : groupModel.usersOnline;
    return usersOnlineList;
  }

  @override
  void onClose() {
    try {
      disconnectSockets();
    } catch (e) {
      // print("CHANNEL ONLINE USERS");
    }
    super.onClose();
  }
}
