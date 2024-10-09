import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class SelectAttendance extends StatelessWidget {
  const SelectAttendance(
      {super.key, this.onTap, required this.color, this.size=BSizes.iconAttendance});
  final void Function()? onTap;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        onTap: onTap,
        splashColor: Colors.black26,
        child: Ink(
            width: size,
            height: size,
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(BSizes.iconButtonMd))),
            )));
  }
}
