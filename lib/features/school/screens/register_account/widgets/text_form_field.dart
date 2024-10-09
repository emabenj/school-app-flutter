import 'package:flutter/material.dart';

class TextFormFieldRegister extends StatelessWidget {
  const TextFormFieldRegister({super.key, required this.labelText});
  final String labelText;
  @override
  Widget build(BuildContext context) {

    final decoration = InputDecoration(      
        labelText: labelText);

    return TextFormField(
        decoration: decoration
      );
  }
}

