import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/selecting_container.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/user_list_container.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersContainer extends StatefulWidget {
  const UsersContainer({super.key, required this.forT, required this.onTap});
  final bool forT;
  final void Function() onTap;

  @override
  State<UsersContainer> createState() => _UsersContainerState();
}

class _UsersContainerState extends State<UsersContainer> {
  final controller = SelectChatController.instance;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = BColors.greenDark;
    return Obx(() => controller.isSelecting()
        ? SelectingContainer(
            onTaps: List.generate(
                controller.statusForTeacher.length,
                (index) =>
                    () => changeStatus(controller.statusForTeacher[index])),
                    backgroundColor: backgroundColor)
        : UserListContainer(
            forT: widget.forT, backgroundColor: backgroundColor, onTap: widget.onTap,));
  }

  void changeStatus(MessagesStatus newStatus) {
    setState(() {
      controller.setStatus(newStatus);
    });
  }

  void update(){
    // setState(() {
      
    // });
  }
}
