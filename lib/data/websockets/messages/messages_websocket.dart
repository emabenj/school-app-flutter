import 'dart:convert';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/util/websocket/websocket_connection.dart';

class MessagesWebSocket {
  final _userId = AuthenticationRepository.instance.userId();
  final _forT = NavigationController.instance.isTeacher();

  final _channelHelper = BWebSocketConnection();
  static const String typeChatMessage = "chat_message";
  static const String typeRecentMessage = "recent_message";

  void connect(List<int> usersIds) {
    if (usersIds.isNotEmpty) {
      final controller = ChatController.instance;
      final totalIds = usersIds.length;
      final userIdString = _userId.toString();
      final endpoints = List.generate(totalIds, (index) {
        final firstUserId = _forT ? userIdString : usersIds[index].toString();
        final secondUserId = _forT ? usersIds[index].toString() : userIdString;
        return "ws/chat/$firstUserId-$secondUserId/";
      });

      final List<void Function(dynamic)> onDatas = List.generate(
          totalIds,
          (index) => (message) {
// Decodificación del el mensaje
                final decodedMessage = json.decode(message);
                final typeMessage = decodedMessage['type'];
                final newMessage =
                    MessageModel.fromJson(decodedMessage['message']);
                if (newMessage.transmitter != _userId) {
                  if (typeMessage == typeChatMessage ||
                      OnlineUserController.instance.idUserChat != null) {
                    // Agregar mensaje recibido a la lista de mensajes del chat
                    controller.messageList.add(newMessage);
                    controller.moveScrollToBottom();
                  }
                  controller.updateRecentMessage(
                      fromUser: true, newsMessage: newMessage);
                }
              });

      _channelHelper.createNewConnections(endpoints, onDatas);
    }
  }

  void sendMessages(List<MessageModel> newsMessages, {bool recent = false}) {
    final totalMessages = newsMessages.length;
    final endpoints = List.generate(totalMessages, (index) {
      final users = usersByRole(newsMessages[index]);
      final firstUserId = users[0];
      final secondUserId = users[1];
      return "ws/chat/$firstUserId-$secondUserId/";
    });
    final messages = List.generate(
        totalMessages,
        (index) => json.encode({
              'type': recent ? typeRecentMessage : typeChatMessage,
              'message': newsMessages[index].toJson(),
            }));
    _channelHelper.sendMessages(endpoints, messages);
  }

  List<int> usersByRole(MessageModel message) {
    final transmitter = message.transmitter;
    final receiver = message.receiver;
    final transmitterIsTeacher = _forT && _userId == transmitter;
    final firstUserId = transmitterIsTeacher ? transmitter : receiver;
    final secondUserId = transmitterIsTeacher ? receiver : transmitter;
    return [firstUserId, secondUserId];
  }

  void disconnect() {
    _channelHelper.disconnectChannels();
  }
}
