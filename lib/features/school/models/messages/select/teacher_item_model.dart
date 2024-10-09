import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';

class TeacherItemModel extends UserItemModel {
  final int course;
  TeacherItemModel(
      {required super.id,
      required super.name,
      required super.lastname,
      required super.email,
      required this.course,
      super.role = Roles.teacher});

  Color getColor() => ItemListController.instance.course.value.getColor(course);
  String getCourseImg() => ItemListController.instance.course.value.getImg(course);
  String getCourseName() => ItemListController.instance.course.value.mapper.getTextById(course);

  factory TeacherItemModel.fromJson(Map<String, dynamic> json) =>
      TeacherItemModel(
          id: json["usuario_id"],
          name: json["nombres"],
          lastname: json["apellidos"],
          email: json["email"],
          course: json["curso"]);

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "nombres": name,
  //       "apellidos": lastname,
  //       "email": email,
  //       "curso": course,
  //     };
}

class TeacherItemListModel {
  final List<TeacherItemModel> _teachers;

  TeacherItemListModel({required List<TeacherItemModel> teachers})
      : _teachers = teachers;

  factory TeacherItemListModel.fromJson(List<dynamic> json) {
    return TeacherItemListModel(
        teachers: json.map((item) => TeacherItemModel.fromJson(item)).toList());
  }

  List<TeacherItemModel> list() {
    return _teachers;
  }
}
