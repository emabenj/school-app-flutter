import 'package:colegio_bnnm/common/widgets/buttons/icon_circular_button.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BCancelButton extends StatelessWidget {
  const BCancelButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconCircularButton(
        onTap: onTap,
        size: const Size(BSizes.iconButtonMd, BSizes.iconButtonMd),
        img: BImages.cancel);
  }
}
