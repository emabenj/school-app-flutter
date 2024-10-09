import 'package:flutter/material.dart';

class ClassroomInfo extends StatelessWidget {
  const ClassroomInfo({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium);
  }
}
