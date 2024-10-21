import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/recent_list_container.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/sending_container.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentMessages extends StatelessWidget {
  const RecentMessages({super.key, required this.forT, required this.onTap});
  final bool forT;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColorItem =
        BHelperFunctions.isDarkMode(context) ? BColors.grey : BColors.white;
    return Obx(() => SelectChatController.instance.isSending()
        ? SendingContainer(backgroundColor: backgroundColorItem, update: onTap)
        : RecentListContainer(backgroundColor: backgroundColorItem, forT: forT));
  }
}
