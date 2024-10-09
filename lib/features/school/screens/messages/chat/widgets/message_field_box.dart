import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);

    final controller = ChatController.instance;
    // final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(BSizes.borderRadiusContainerMd));

    final inputDecoration = InputDecoration(
        hintText: BTexts.chatLabel,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: dark ? BColors.dark : BColors.light),
        filled: true,
        fillColor: dark ? BColors.white : BColors.black);
    final textStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .apply(color: dark ? BColors.black : BColors.white);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: BSizes.xs),
        child: Row(children: [
          Expanded(
              flex: 4,
              child: TextFormField(
                  onTapOutside: (event) {
                    controller.focusNode.unfocus();
                  },
                  focusNode: controller.focusNode,
                  controller: controller.textController,
                  decoration: inputDecoration,
                  style: textStyle,
                  onFieldSubmitted: (value) => controller.onFieldSubmitted())),
          const SizedBox(width: BSizes.sm),
          Expanded(
              child: BElevatedButton(
                  text: BTexts.chatButton,
                  buttonColor: BColors.greenDark,
                  onPressed: controller.onFieldSubmitted,
                  dark: true)),
          Expanded(
              child: IconButton(
                  onPressed: controller.selectPicture,
                  icon: const Icon(Icons.browse_gallery_rounded)))
        ]));
  }
}
