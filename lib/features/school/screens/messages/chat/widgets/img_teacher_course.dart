import 'package:flutter/material.dart';

class ImageTeacherCourse extends StatelessWidget {
  final String imagen;
  const ImageTeacherCourse({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagen);
  }
}
