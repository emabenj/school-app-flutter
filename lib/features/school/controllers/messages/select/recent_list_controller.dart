import 'package:colegio_bnnm/data/websockets/messages/messages_websocket.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:get/get.dart';

class RecenListController extends GetxController {
  static RecenListController get instance => Get.find();
  // VARIABLES
  final _messageWebSocket = MessagesWebSocket();

  void connectWebSockets(List<int> usersIds) {
    _messageWebSocket.connect(usersIds);
  }

  void sendMessagesByWebSockets(List<MessageModel> newsMessages,
      {bool recent = false}) {
    _messageWebSocket.sendMessages(newsMessages, recent: recent);
  }

  List<int> getUsers(MessageModel message) {
    return _messageWebSocket.usersByRole(message);
  }

  @override
  void onClose() {
    _messageWebSocket.disconnect();
    super.onClose();
  }
}
