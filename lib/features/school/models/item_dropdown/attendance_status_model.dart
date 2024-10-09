import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:flutter/material.dart';

class AttendanceStatusModel {
  static get url => "estados/asistencia/";
  final int id;
  final String name;
  final Color color;

  AttendanceStatusModel({
    required this.id,
    required this.name,
    required this.color,
  });
  static AttendanceStatusModel empty() =>
      AttendanceStatusModel(id: 0, name: "", color: Colors.transparent);

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) =>
      AttendanceStatusModel(
        id: json["id"],
        name: json["nombre"],
        color: BFormatter.colorFromHex(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
        "color": "",
      };
}

class AttendanceStatusListModel {
  final List<AttendanceStatusModel> _statusList;

  AttendanceStatusListModel({required List<AttendanceStatusModel> statusList})
      : _statusList = statusList;

  factory AttendanceStatusListModel.fromJson(List<Map<String, dynamic>> json) {
    return AttendanceStatusListModel(
        statusList:
            json.map((item) => AttendanceStatusModel.fromJson(item)).toList());
  }

  List<AttendanceStatusModel> list() {
    return _statusList;
  }
}
