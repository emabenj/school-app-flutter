import 'package:colegio_bnnm/common/widgets/buttons/clickable_widgets.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/common/widgets/groups/icon_circular_button_list.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ExtraButtonsGroupContainer extends StatelessWidget {
  const ExtraButtonsGroupContainer({
    super.key,
    this.forButton = false,
  });
  final bool forButton;

  @override
  Widget build(BuildContext context) {
    final controller = SelectController.instance;

    final sizeButton = forButton ? BSizes.iconButtonLg : BSizes.iconButtonMd;
    final imgs = forButton ? BImages.forClassrooms : BImages.forAClassroom;
    final sizeExtra = BSizes.getSizeContainer(imgs.length, isMd: !forButton);

    // ORDER: SEND, HOMEWORK, QUALIFICATIONS
    final directionActions = SelectController.actions;
    final actions = List.generate(
        imgs.length,
        (index) => () {
              forButton
                  ?"" 
                  // print("AULAS")
                  : controller.setState(directionActions[index]);
            });
    return BRoundedContainer(
        backgroundColor: forButton
            ? BColors.greenDark
            : BHelperFunctions.isDarkMode(context)
                ? BColors.black
                : BColors.grey,
        padding: const EdgeInsets.symmetric(
            horizontal: BSizes.lg, vertical: BSizes.sm),
        rounded: forButton ? Rounded.upLg : Rounded.down,
        size: sizeExtra,
        child: BClickablesWidgets(
            widgets: BIconCircularButtonList(
                    size: Size(sizeButton, sizeButton),
                    imgs: imgs,
                    actions: actions,
                    enabled: List.generate(imgs.length, (index) => true))
                .get()));
  }
}
