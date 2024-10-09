import 'package:colegio_bnnm/common/widgets/containers/circular_container.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserItemVertical extends StatelessWidget {
  const UserItemVertical(
      {super.key,
      this.online,
      required this.img,
      required this.content});
  final bool? online;
  final String img;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    const sizeCircle = BSizes.iconContainer;
    const sizeOnline = sizeCircle * .27;
    return Column(children: [
      // USER IMG
      Stack(children: [
        Image.asset(img, width: sizeCircle, height: sizeCircle),
        Positioned(
            right: 0,
            bottom: 0,
            child: BCircularContainer(
                width: sizeOnline,
                height: sizeOnline,
                backgroundColor: online != null
                    ? online!
                        ? BColors.greenLight
                        : BColors.grey
                    : Colors.transparent))
      ]),
      const SizedBox(height: BSizes.xs),
      content
    ]);
  }
}
