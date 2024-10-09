import 'package:colegio_bnnm/common/widgets/buttons/icon_circular_button.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class ContainerIconButtons extends StatelessWidget {
  const ContainerIconButtons(
      {super.key,
      this.widthContainer,
      this.sizeIconButton =
          const Size(BSizes.iconButtonMd, BSizes.iconButtonMd),
      this.padding = BSizes.sm,
      this.color = BColors.greenLight,
      this.circular = true,
      this.row = true,
      required this.functions,
      required this.imgs,
      this.enabled});
  final double? widthContainer;
  final Size sizeIconButton;
  final double padding;
  final Color? color;
  final bool circular;
  final List<void Function()> functions;
  final List<bool>? enabled;
  final List<String> imgs;
  final bool row;
  @override
  Widget build(BuildContext context) {
    final enabledList = enabled ?? List.generate(imgs.length, (index) => true);
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(BSizes.borderRadiusContainerLg),
        color: color);

    final icons = List.generate(
        imgs.length,
        (index) => IconCircularButton(
              onTap: functions[index],
              size: sizeIconButton,
              img: imgs[index],
              enabled: enabledList[index],
            ));
    return Container(
        decoration: decoration,
        width: widthContainer,
        // height: sizeContainer.height,
        padding: EdgeInsets.all(padding),
        child: row
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: icons)
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: icons));
  }
}
