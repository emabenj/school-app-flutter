import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/appbar/chat_appbar.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/classroom_info.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/img_teacher_course.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/message_field_box.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/message_list.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.forT});
  final bool forT;

  @override
  Widget build(BuildContext context) {
    final controller = ChatController.instance;
    final onlineController = OnlineUserController.instance;
    // Cargar mensajes y establecer conexión WebSocket
    controller.loadMessages();
    return PopScope(
      onPopInvoked: (didPop) {
        controller.updateRecentMessage();
        onlineController.idUserChat = null;
      },
      child: Obx(() {
        final name = onlineController.nameUserChat;
        final online = onlineController.onlineUserChat.value;
        return Scaffold(
            appBar: BChatAppBar(
              color: forT ? BColors.grey : BColors.redLight,
              img: forT ? BImages.authorised : BImages.teacher,
              name: name,
              online: online,
              widget: forT
                  ? ClassroomInfo(text: controller.extraInfo)
                  : ImageTeacherCourse(imagen: controller.extraInfo),
            ),
            body: Padding(
                padding: BSpacingStyles.paddingChat,
                child: Column(children: [
                  const MessageList(),
                  MessageFieldBox(onValue: controller.sendMessageToOnePerson)
                ])));
      }),
    );
  }
}
