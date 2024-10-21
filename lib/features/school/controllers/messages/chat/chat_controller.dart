import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/messages/messages_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/recent_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/conversation_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/recent_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final _authRepository = AuthenticationRepository.instance;
  // VARIABLES
  final chatScrollController = ScrollController();
  final textController = TextEditingController();
  final focusNode = FocusNode();
  final receiverUserId = 0.obs;
  String extraInfo = "";

  final messageList = <MessageModel>[].obs;
  final recentChatList = <RecentConversationModel>[].obs;
  // final _channelHelper = BWebSocketConnection();
  ConversationModel conversation = ConversationModel.empty();
  //
  //
  //
  Future<void> loadMessages() async {
    final conversationId = conversation.id;
    await _authRepository.responseValidatorControllers(() async {
      final messages =
          await MessagesRepository.instance.getMessages(conversationId);
      messageList.value = messages;
      await moveScrollToBottom();
    }, back: true, titleMessage: "Error buscando mensajes");
  }

  Future<void> sendMessageToOnePerson(String text) async {
    if (text.trim().isNotEmpty) {
      await _authRepository.responseValidatorControllers(() async {
        //
        // INFO
        //
        final messageReceiverId = receiverUserId.value;
        final newMessage = await MessagesRepository.instance
            .sendMessageToOnePerson(messageReceiverId, text, imgFile.value);
        messageList.add(newMessage);
        await moveScrollToBottom();
        // Enviar mensaje a través del WebSocket
        RecenListController.instance.sendMessagesByWebSockets([newMessage]);

        imgFile.value = null;
      }, titleMessage: "Error al enviar mensaje");
    }
  }

  Future<void> sendMessageManyPeople(String text, List<int> receivers) async {
    await _authRepository.responseValidatorControllers(() async {
      // INFO
      final newsMessages = await MessagesRepository.instance
          .sendMessageToManyPeople(receivers, text, imgFile.value);
      for (var nm in newsMessages) {
        updateRecentMessage(fromUser: true, newsMessage: nm);
      }
      RecenListController.instance
          .sendMessagesByWebSockets(newsMessages, recent: true);
      imgFile.value = null;
    }, titleMessage: "Error al enviar mensaje a los apoderados");
  }

  void updateRecentMessage({bool fromUser = false, MessageModel? newsMessage}) {
    if (!fromUser && messageList.isNotEmpty) {
      updateRecentMessage(
        fromUser: true,
        newsMessage: messageList.last,
      );
    } else if (newsMessage != null) {
      final lastMessage = newsMessage;
      final conversationId = lastMessage.conversation;
      // Buscar el índice del chat reciente por `conversationId`
      final indexRecentChatItem = recentChatList
          .indexWhere((rc) => rc.conversation.id == conversationId);
      // Verificar si se encuentra el chat en la lista
      if (indexRecentChatItem != -1) {
        // Actualizar el último mensaje de la conversación reciente
        recentChatList[indexRecentChatItem].recentMessage = lastMessage;
      } else {
        final users = RecenListController.instance.getUsers(lastMessage);
        // Crear una conversacion para la lista de Conversaciones Recientes (solo Docentes)
        final conversation = ConversationModel(
          id: lastMessage.conversation,
          firstParticipant: users[0],
          secondParticipant: users[1],
        );
        final recentConversation = RecentConversationModel(
            conversation: conversation, recentMessage: lastMessage);
        recentChatList.add(recentConversation);
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
