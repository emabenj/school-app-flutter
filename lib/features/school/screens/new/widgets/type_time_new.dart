import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class TypeTimeNew extends StatelessWidget {
  const TypeTimeNew({super.key, required this.type, required this.time, required this.style});
  final String type;
  final String time;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BSizes.md,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(type, style: style), const SizedBox(width: BSizes.sm), Text(time, style: style)]),
    );
  }
}
