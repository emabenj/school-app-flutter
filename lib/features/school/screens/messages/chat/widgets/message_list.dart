import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/message_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChatController.instance;
    return Expanded(
        child: Obx(() => ListView.builder(
            controller: controller.chatScrollController,
            itemCount: controller.messageList.length,
            itemBuilder: (context, index) =>
                MessageChat(model: controller.messageList[index], index: index))));
  }
}
