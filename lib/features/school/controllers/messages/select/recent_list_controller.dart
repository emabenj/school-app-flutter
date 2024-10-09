import 'dart:convert';

import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RecenListController extends GetxController {
  static RecenListController get instance => Get.find();
  final _controller = ChatController.instance;
  final _channelsOnces = <WebSocketChannel>[];
  final _channelsStatic = <WebSocketChannel>[];
  // VARIABLES

  void connectWebSockets(
      {List<MessageModel>? messages, bool sendAndClose = false}) {
    final idsList = messages != null
        ? messages.map((e) => e.conversation).toList()
        : _controller.recentChatList
            .map((rchat) => rchat.conversation.id)
            .toList();
    final totalChats = idsList.length;
    // DESCONECTAR LOS CANALES ABIERTOS
    if (sendAndClose) disconnectChannels();
    for (var i = 0; i < totalChats; i++) {
      final conversationId = idsList[i];

      final channel = WebSocketChannel.connect(
          Uri.parse('ws://${APIConstants.domain}ws/chat/$conversationId/'));

      channel.stream.listen((message) {
        // Decodificación del el mensaje
        final decodedMessage = json.decode(message);
        final newMessage = MessageModel.fromJson(decodedMessage['message']);
        if (sendAndClose ||
            newMessage.transmitter !=
                AuthenticationRepository.instance.userId()) {
          _controller
              .updateRecentMessage(fromUser: true, newsMessages: [newMessage]);
        }
      });
      if (sendAndClose) {
        for (var i = 0; i < messages!.length; i++) {
          // También enviar mensaje a través del WebSocket a cada Apoderado
          channel.sink.add(json.encode({
            'message': messages[i].toJson(),
          }));
        }
      }
      sendAndClose ? _channelsOnces.add(channel) : _channelsStatic.add(channel);
    }
  }

  void disconnectChannels() {
    if (_channelsOnces.isNotEmpty) {
      for (var c in _channelsOnces) {
        c.sink.close();
      }
      _channelsOnces.clear();
    }
  }
}
