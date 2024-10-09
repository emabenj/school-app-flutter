import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BWidgetList {
  BWidgetList(
      {this.widgets,
      this.separationLenght = BSizes.spaceBtwInputFields,
      this.row = false,
      this.widget,
      this.total});

  List<Widget>? widgets;
  final double separationLenght;
  final bool row;

  final Widget? widget;
  final int? total;

  List<Widget> get() {
    widgets ??= widget != null && widgets == null
        ? List.generate(total ?? 0, (index) => widget!)
        : [];

    for (var i = 1; i < widgets!.length; i += 2) {
      widgets!.insert(
          i,
          row
              ? SizedBox(width: separationLenght)
              : SizedBox(height: separationLenght));
    }
    return widgets!;
  }
}
