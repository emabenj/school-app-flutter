import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/recent_message_model.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class RecentChatItem extends StatelessWidget {
  const RecentChatItem(
      {super.key,
      required this.background,
      required this.onTap,
      required this.model,
      required this.forT});
  final Color background;
  final void Function() onTap;
  final RecentConversationModel model;
  final bool forT;

  @override
  Widget build(BuildContext context) {
    final id = forT
        ? model.conversation.secondParticipant
        : model.conversation.firstParticipant;
    return InkWell(
        onTap: onTap,
        splashColor: Colors.black12,
        child: Ink(
            child: BRoundedContainer(
                padding: const EdgeInsets.all(BSizes.sm),
                backgroundColor: background,
                size: const Size(
                    double.infinity, BSizes.iconButtonLg + BSizes.sm * 2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(BImages.user,
                          fit: BoxFit.fill,
                          width: BSizes.iconButtonLg,
                          height: BSizes.iconButtonLg),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // NAME
                            SizedBox(
                              width: BHelperFunctions.screenWidth() * .63,
                              child: Text(
                                  SelectChatController.instance
                                      .getUserToRecentMessage(forT, id)
                                      .getName(),
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                  softWrap: false),
                            ),
                            Row(children: [
                              // MESSAGE
                              SizedBox(
                                  width: BHelperFunctions.screenWidth() * .51,
                                  child: Text(model.getRecentMessage(),
                                      maxLines: 1, softWrap: false)),
                              const SizedBox(width: BSizes.sm),
                              // TIME
                              Text(model.hourInRecentMessage(),
                                  style: Theme.of(context).textTheme.titleLarge)
                            ])
                          ])
                    ]))));
  }
}
