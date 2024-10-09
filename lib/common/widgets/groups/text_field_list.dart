import 'package:colegio_bnnm/common/widgets/groups/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';

class TextFieldList {
  const TextFieldList(
      {required this.labels,
      required this.style,
      required this.controllers,
      required this.validators,
      this.separationLenght = BSizes.spaceBtwInputFields});

  final List<String> labels;
  final List<TextEditingController> controllers;
  final List<String? Function(String?)>? validators;
  final double separationLenght;
  final TextStyle? style;

  List<Widget> get() {
    final List<Widget> items = List.generate(
        labels.length,
        (index) => TextFormField(
            validator: validators != null ? validators![index] : null,
            controller: controllers[index],
            style: style,
            decoration: InputDecoration(labelText: labels[index])));
    return BWidgetList(widgets: items, separationLenght: separationLenght)
        .get();
  }
}
