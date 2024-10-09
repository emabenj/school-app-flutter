import 'package:colegio_bnnm/common/widgets/buttons/icon_circular_button.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BIconCircularButtonList {
  const BIconCircularButtonList(
      {this.backgroundColorIcon,
      required this.size,
      required this.imgs,
      required this.actions,
      required this.enabled,
      this.separationLenght = BSizes.spaceBtwInputFields});

  final List<String> imgs;
  final List<void Function()> actions;
  final List<bool> enabled;
  final double separationLenght;
  final Size size;
  final Color? backgroundColorIcon;

  List<Widget> get() {
    final List<Widget> items = List.generate(
        imgs.length,
        (index) => IconCircularButton(
              onTap: actions[index],
              img: imgs[index],
              size: size,
              backgroundColor: backgroundColorIcon,
              enabled: enabled[index],
            ));
    for (var i = 1; i < items.length; i += 2) {
      items.insert(i, SizedBox(height: separationLenght));
    }
    return items;
  }
}
