import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:flutter/material.dart';

class CourseModel {
  static String get url => "cursos/";
  final int id;
  final String name;
  final int? levelId;

  CourseModel({
    required this.id,
    required this.name,
    this.levelId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        name: json["nombre"],
        levelId: json["nivel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
        "nivel": levelId,
      };
  Color getcolor() {
    return ItemListController.instance.course.value.getColor(id);
  }
}

class CourseListModel {
  final List<CourseModel> _courses;

  CourseListModel({required List<CourseModel> courses}) : _courses = courses;

  factory CourseListModel.fromJson(List<Map<String, dynamic>> json) {
    return CourseListModel(
        courses: json.map((item) => CourseModel.fromJson(item)).toList());
  }

  List<CourseModel> list() {
    return _courses;
  }
}
