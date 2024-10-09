import 'package:colegio_bnnm/common/widgets/containers/selected_container.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';
import 'package:colegio_bnnm/features/school/screens/select/widgets/container_choosed.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ContainerToChoose extends StatefulWidget {
  const ContainerToChoose(
      {super.key,
      required this.onTap,
      required this.pressed,
      required this.forT,
      required this.model});
  final void Function() onTap;
  final bool pressed;
  final bool forT;
  final SelectModel model;

  @override
  State<ContainerToChoose> createState() => ContainerToChooseState();
}

class ContainerToChooseState extends State<ContainerToChoose> {
  @override
  Widget build(BuildContext context) {
    final opacity =
        BHelperFunctions.isDarkMode(context) ? BColors.light : BColors.dark;
    const size = Size(double.infinity, BSizes.iconContainer + BSizes.sm * 2);
    return BSelectedContainer(
        onTap: widget.onTap,
        ubi: Positions.outBottom,
        pressed: widget.pressed,
        colorOpacity: opacity,
        radius: true,
        withOpacity: SelectController.instance.selectingMany(),
        size: size,
        child: ContainerChoosed(model: widget.model, height: size.height));
  }
}
