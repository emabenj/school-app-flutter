import 'package:colegio_bnnm/common/widgets/scaffold/two_containers_scaffold.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/recent_messages_select.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/users_container_select.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SelectChatScreen extends StatefulWidget {
  const SelectChatScreen({super.key, required this.forT});
  final bool forT;

  @override
  State<SelectChatScreen> createState() => _SelectChatScreenState();
}

class _SelectChatScreenState extends State<SelectChatScreen> {
  final controller = SelectChatController.instance;
  @override
  void initState() {
    super.initState();
    controller.loadRecentMessages();
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final title = controller.extraInfo;
    const subTitle = BTexts.messageRecent;
    final data = ForScaffoldModel(
        title,
        subTitle,
        UsersContainer(forT: widget.forT, onTap: update),
        RecentMessages(forT: widget.forT, onTap: update),
        dark ? BColors.white : BColors.grey,
        dark ? BColors.light : BColors.dark);
    return TwoContainerScaffold(modelScaffold: data);
  }

  void update() {
    // controller.setUsersOnline(controller.isAuthorisedsList());
    setState(() {});
  }
}
