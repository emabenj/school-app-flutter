// import 'dart:convert';

import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/homework/details_homework_model.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class HomeworkModel {
  static get urlList => "tareas/";
  final int id;
  final String description;
  final DateTime? dueDate;
  final int status;

  HomeworkModel({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  String date() => dueDate == null
      ? ""
      : BFormatter.formatDateToString(dueDate);

  static HomeworkModel empty() =>
      HomeworkModel(id: 0, description: "", dueDate: null, status: 0);

  // factory HomeworkModel.fromRawJson(String str) =>
  //     HomeworkModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => HomeworkModel(
        id: json["id"],
        description: json["descripcion"],
        dueDate: BFormatter.formatStringToDate(json["fecha_entrega"])!,
        status: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": description,
        "fecha_entrega": BFormatter.formatDateToString(dueDate),
        "estado": status,
      };

  DetailsHomeworkModel details() => DetailsHomeworkModel(
      ItemListController.instance.homework.value.isUnderRevision(status)
          ? "${ItemListController.instance.homework.value.mapper.getTextById(status)}, hasta el ${BFormatter.formatDateToString(dueDate)}"
          : ItemListController.instance.homework.value.mapper
              .getTextById(status),
      description);
}

class HomeworkListModel {
  final List<HomeworkModel> _homeworks;

  HomeworkListModel({required List<HomeworkModel> homeworks})
      : _homeworks = homeworks;

  factory HomeworkListModel.fromJson(List<dynamic> json) {
    return HomeworkListModel(
        homeworks: json.map((item) => HomeworkModel.fromJson(item)).toList());
  }

  List<HomeworkModel> list() {
    return _homeworks;
  }

  List<dynamic> listDetails() {
    return _homeworks.map((e) => e.details()).toList();
  }
}
