import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/common/widgets/buttons/clickable_widgets.dart';
import 'package:colegio_bnnm/common/widgets/groups/icon_circular_button_list.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/select_chat_controller.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
// import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendingContainer extends StatelessWidget {
  const SendingContainer(
      {super.key, required this.backgroundColor, required this.update});
  final Color backgroundColor;
  final void Function() update;

  @override
  Widget build(BuildContext context) {
    final controller = SelectChatController.instance;
    final actions = [
      () {
        // PREGUNTAR SI ESTAS SEGURO EN CASO HAYAN DATOS EN EL TEXT AREA
        controller.setStatus(MessagesStatus.selecting);
      },
      () => controller.sendMessageToParents(),
      () =>controller.cleanPressedList()
    ];
    const sizeButton = 30.0;
    return Column(children: [
      Form(
        key: controller.manyPeopleFormKey,
        child: TextFormField(
            controller: controller.textController,
            validator: (value) =>
                BValidator.validateEmptyText("Mensaje", value),
            maxLines: 16,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: BTexts.chatLabel,
                filled: true,
                fillColor: backgroundColor,
                enabledBorder:
                    const OutlineInputBorder(borderRadius: BRadiusStyles.all),
                focusedBorder:
                    const OutlineInputBorder(borderRadius: BRadiusStyles.all)),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center),
      ),
      const SizedBox(height: BSizes.spaceBtwInputFields),
      Stack(children: [
        Obx(
          () => BClickablesWidgets(
              widgets: BIconCircularButtonList(
                      size:
                          const Size(BSizes.iconButtonMd, BSizes.iconButtonMd),
                      imgs: BImages.forSendingMessage,
                      actions: actions,
                      enabled: [
                        true,
                        controller.allowSend.value,
                        controller.allowSend.value
                      ],
                      backgroundColorIcon: BColors.greenDark)
                  .get()),
        ),
        Positioned(
            right: BSizes.iconButtonMd +
                15 +
                BSizes.spaceBtwInputFields * 2 +
                sizeButton,
            top: 8,
            child: Obx(
              () => Visibility(
                visible: controller.allowSend.value,
                child: Container(
                    width: sizeButton,
                    height: sizeButton,
                    decoration: BoxDecoration(
                        color: BColors.redLight,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(controller.countSend.value.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(color: Colors.yellow)))),
              ),
            ))
      ])
    ]);
  }
}
