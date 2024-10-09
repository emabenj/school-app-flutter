import 'dart:convert';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/messages/messages_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/recent_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/conversation_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/recent_message_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  // VARIABLES
  final chatScrollController = ScrollController();
  final textController = TextEditingController();
  final focusNode = FocusNode();
  final receiverUserId = 0.obs;
  String extraInfo = "";

  final RxList<MessageModel> messageList = RxList([]);
  final recentChatList = <RecentConversationModel>[].obs;
  late WebSocketChannel channel;
  ConversationModel conversation = ConversationModel.empty();
  //
  //
  //
  Future<void> loadMessages() async {
    final conversationId = conversation.id;
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      final messages =
          await MessagesRepository.instance.getMessages(conversationId);
      messageList.value = messages;
      await moveScrollToBottom();
    }, back: true, titleMessage: "Error buscando mensajes");
    connectWebSocket(conversationId);
  }

  // Establecer conexión WebSocket para escuchar mensajes
  void connectWebSocket(int conversationId) {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://${APIConstants.domain}ws/chat/$conversationId/'));

    channel.stream.listen((message) {
      // Decodificación del el mensaje
      final decodedMessage = json.decode(message);
      final newMessage = MessageModel.fromJson(decodedMessage['message']);
      if (newMessage.transmitter !=
          AuthenticationRepository.instance.currentUser()!.user.userId) {
        messageList.add(newMessage); // Agregar mensaje recibido a la lista
        moveScrollToBottom();
        updateRecentMessage(fromUser: true, newsMessages: [newMessage]);
      }
    });
  }

  // Desconectar el WebSocket
  @override
  void onClose() {
    try {
      channel.sink.close();
    } catch (e) {
      // print("CHANNEL CHAT");
    }
    super.onClose();
  }

  Future<void> sendMessageToOnePerson(String text) async {
    if (text.trim().isNotEmpty) {
      await AuthenticationRepository.instance.responseValidatorControllers(() async {
        //
        // INFO
        //
        final messageReceiverId = receiverUserId.value;
        final newMessage = await MessagesRepository.instance
            .sendMessageToOnePerson(messageReceiverId, text, imgFile.value);
        messageList.add(newMessage);
        await moveScrollToBottom();
        // También enviar mensaje a través del WebSocket
        channel.sink.add(json.encode({
          'message': newMessage.toJson(),
        }));
        imgFile.value = null;
      }, titleMessage: "Error al enviar mensaje");
    }
  }

  Future<void> sendMessageManyPeople(String text, List<int> receivers) async {
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      // INFO
      final newsMessages = await MessagesRepository.instance
          .sendMessageToManyPeople(receivers, text, imgFile.value);
      final recentListController = RecenListController.instance;
      recentListController.connectWebSockets(
          messages: newsMessages, sendAndClose: true);
      imgFile.value = null;
    }, titleMessage: "Error al enviar mensaje a los apoderados");
  }

  void updateRecentMessage(
      {bool fromUser = false, List<MessageModel>? newsMessages}) {
    //, int? conversationId}) {
    if (!fromUser && messageList.isNotEmpty) {
      updateRecentMessage(
        fromUser: true,
        newsMessages: [messageList.last],
        // conversationId: conversation.id
      );
    } else if (newsMessages!.isNotEmpty) {
      for (var i = 0; i < newsMessages.length; i++) {
        final lastMessage = newsMessages[i];
        final conversationId = lastMessage.conversation;
        // Buscar el índice del chat reciente por `conversationId`
        final indexRecentChatItem = recentChatList
            .indexWhere((rc) => rc.conversation.id == conversationId);
        // Verificar si se encuentra el chat en la lista
        if (indexRecentChatItem != -1) {
          // Actualizar el último mensaje de la conversación reciente
          recentChatList[indexRecentChatItem].recentMessage = lastMessage;
        } else {
          // Crear una conversacion para la lista de Conversaciones Recientes
          final recentConversation = RecentConversationModel(
              conversation: conversation, recentMessage: lastMessage);
          recentChatList.insert(0, recentConversation);
        }
      }
      // Notificar al widget que lista las conversaciones recientes en SelectChatScreen
      recentChatList.refresh();
    }
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (messageList.isNotEmpty && chatScrollController.hasClients) {
      chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut);
    }
  }

  void onFieldSubmitted() {
    String value = textController.value.text;
    textController.clear();
    focusNode.requestFocus();
    sendMessageToOnePerson(value);
  }

  final _picker = ImagePicker();
  final imgFile = Rx<XFile?>(null);
  Future<void> selectPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    imgFile.value = pickedFile;
  }
}
