import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/messages/messages_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/chat_screen.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/cancel_button.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/user_item.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListContainer extends StatefulWidget {
  const UserListContainer(
      {super.key,
      required this.forT,
      required this.backgroundColor,
      required this.onTap});
  final bool forT;
  final Color backgroundColor;
  final void Function() onTap;

  @override
  State<UserListContainer> createState() => _UserListContainerState();
}

class _UserListContainerState extends State<UserListContainer> {
  final controller = SelectChatController.instance;
  final onlineController = OnlineUserController.instance;
  @override
  Widget build(BuildContext context) {
    final size = Size(
        double.infinity, BHelperFunctions.screenHeight() * .26 - BSizes.sm * 2);

    final userList = Obx(() {
      controller.setUsersOnline(widget.forT, widget.onTap);
      final isPressedList = controller.isPressedList;
      return SizedBox(
          height: controller.isAuthorisedsList()
              ? size.height * .6
              : size.height - BSizes.xs * 2,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.getModels().length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: BSizes.sm),
              itemBuilder: (context, index) => UserItem(
                  status: controller.status.value,
                  model: controller.getModels()[index],
                  onTap: () => onTapByStatus(index),
                  pressed:
                      controller.isSending() ? isPressedList[index] : null)));
    });
    return BRoundedContainer(
        padding: const EdgeInsets.all(BSizes.xs),
        backgroundColor: widget.backgroundColor,
        size: size,
        child: Obx(() {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            controller.isAuthorisedsList()
                ? Column(children: [
                    BCancelButton(
                        onTap: () =>
                            controller.setStatus(MessagesStatus.selecting)),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    userList
                  ])
                : userList
          ]);
        }));
  }

  Future<void> onTapByStatus(int index) async {
    if (controller.isSending()) {
      setState(() {
        controller.changeStatusPressed(index);
      });
    } else {
      await AuthenticationRepository.instance.responseValidatorControllers(() async {
        final chatController = ChatController.instance;
        final receiver = widget.forT
            ? controller.parents[index]
            : controller.teachers[index];
        // ESTABLECER nombres y apellidos del usuario
        chatController.receiverUserId.value = receiver.id;
        // ESTABLECER Nombre de Aula o Imagen de curso de Docente
        chatController.extraInfo = widget.forT
            ? controller.extraInfo
            : ItemListController.instance.course.value
                .getImg(controller.teachers[index].course);
        // ESTABLECER id de la conversación
        final conversation =
            (await MessagesRepository.instance.getConversation(receiver.id));
        chatController.conversation = conversation;
        onlineController.idUserChat = receiver.id;
        onlineController.nameUserChat = receiver.getText();
        onlineController.onlineUserChat.value = receiver.online;
        Get.to(() => ChatScreen(forT: widget.forT));
      }, titleMessage: "Error buscando la conversación");
    }
  }
}
