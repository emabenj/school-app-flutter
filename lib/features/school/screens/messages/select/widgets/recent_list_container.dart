import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/chat_screen.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/recent_chat_item.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentListContainer extends StatelessWidget {
  const RecentListContainer(
      {super.key, required this.backgroundColor, required this.forT});
  final Color backgroundColor;
  final bool forT;

  @override
  Widget build(BuildContext context) {
    final controller = SelectChatController.instance;
    final chatController = ChatController.instance;
  final onlineController = OnlineUserController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          itemCount: chatController.recentChatList.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: BSizes.sm),
          itemBuilder: (context, index) => RecentChatItem(
              background: backgroundColor,
              forT: forT,
              onTap: () {
                // BUSCAR id de receptor entre los usuarios
                final userList =
                    forT ? controller.parents : controller.teachers;
                final receiverId = forT
                    ? chatController
                        .recentChatList[index].conversation.secondParticipant
                    : chatController
                        .recentChatList[index].conversation.firstParticipant;
                final receiver =
                    userList.firstWhere((user) => user.id == receiverId);
                chatController.receiverUserId.value = receiver.id;
                // ESTABLECER Nombre de Aula o Imagen de curso de Docente
                chatController.extraInfo = forT
                    ? controller.extraInfo
                    : ItemListController.instance.course.value
                        .getImg(controller.teachers[index].course);
                // ESTABLECER el id de la Conversación
                chatController.conversation =
                    chatController.recentChatList[index].conversation;

                onlineController.idUserChat = receiver.id;
                onlineController.nameUserChat = receiver.getText();
                onlineController.onlineUserChat.value = receiver.online;
                Get.to(() => ChatScreen(forT: forT));
              },
              model: chatController.recentChatList[index])),
    );
  }
}
