import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';
import 'package:flutter/material.dart';

class CourseEnumMapper {
  static const _courses = Courses.values;
  static final _texts = BTexts.coursesList + BTexts.coursesList;
  final List<dynamic> _models;
  late TextEnumMapper mapper;

  static final _colors = BColors.coursesColors + BColors.coursesColors;

  CourseEnumMapper(this._models) {
    mapper = TextEnumMapper(_courses, _texts, _models);
  }

  static CourseEnumMapper empty() => CourseEnumMapper(_courses);

  String getImg(int id) {
    const coursePath = BImages.coursePath;
    return "$coursePath${mapper.getEnumById(id).name.toLowerCase().substring(0, 1)}.png";
  }

  Color getColor(int id) {
    return _colors[mapper.indexById(id)];
  }

  List<CourseModel> list() {
    return mapper.list() as List<CourseModel>;
  }

  List<CourseModel> getCourses(int level) {
    return list().where((c) => c.levelId == level).toList();
  }
}
