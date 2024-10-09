import 'package:flutter/material.dart';

class BClickablesWidgets extends StatelessWidget {
  const BClickablesWidgets(
      {super.key,
      this.row = true,
      required this.widgets});
  final List<Widget> widgets;
  final bool row;
  @override
  Widget build(BuildContext context) {
    return row
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: widgets)
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgets);
  }
}
