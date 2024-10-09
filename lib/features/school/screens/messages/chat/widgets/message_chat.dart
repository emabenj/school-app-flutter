import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/features/school/screens/messages/chat/widgets/img_message.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:colegio_bnnm/util/helpers/calculator.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({super.key, required this.model, required this.index});
  final MessageModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = ChatController.instance;
    final isLast = BCalculator.isTheLast(index, controller.messageList.length);
    final isRight = model.isRight();
    final nextEqual =
        BCalculator.followingIsAlsoTheSame(index, controller.messageList);
    final withDate =
        BCalculator.hasTheDateInLessThanXMinutes(index, controller.messageList);

    final decoration = BoxDecoration(
      color: isRight ? BColors.rightMessage : BColors.leftMessage,
      borderRadius: isRight
          ? BRadiusStyles.chatRightMedium
          : BRadiusStyles.chatLeftMedium,
    );
    Widget message = Container(
        decoration: decoration,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: BSizes.md, vertical: BSizes.md),
            child: Text(model.content,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: BColors.white))));
    message = model.content.length > 25 ? Expanded(child: message) : message;
    final time = Text(BFormatter.formatHour(model.date),
        style: Theme.of(context).textTheme.headlineSmall);
    return SizedBox(
        width: BHelperFunctions.screenWidth() * .65,
        child: Column(
          children: [
          withDate ? Text(model.dateInChat()) : const SizedBox(),
          Row(
              mainAxisAlignment:
                  isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                isRight ? time : message,
                const SizedBox(width: BSizes.xs),
                isRight ? message : time
              ]),
          Row(
            mainAxisAlignment:
                  isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              ImagenMessage(imagenes: model.imagenes),
            ],
          ),
          SizedBox(
              height: nextEqual || withDate
                  ? BSizes.xs
                  : isLast
                      ? 0
                      : BSizes.sm)
        ]));
  }
}
