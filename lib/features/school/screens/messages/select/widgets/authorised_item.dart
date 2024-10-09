import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/authorised_item_model.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/user_item_vertical.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class AuthorisedItem extends StatelessWidget {
  const AuthorisedItem({super.key, required this.model, this.onTap});
  final AuthorisedItemModel model;
  // final bool? online;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const textColor = BColors.white;
    final controller = SelectChatController.instance;
    return GestureDetector(
      onTap: onTap,
      child: UserItemVertical(
          online: controller.isSending() ? null : model.online,
          img: model.getImg(),
          content: SizedBox(
              width: BSizes.iconContainer,
              child: Text(model.getText(),
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: controller.isSending()
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: textColor)
                      : Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: textColor)))),
    );
  }
}
