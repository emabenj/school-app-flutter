import 'dart:convert';
import 'package:colegio_bnnm/features/school/models/item_dropdown/level_model.dart';

class GradeModel {
  final int id;
  final int number;
  final LevelModel level;

  GradeModel({
    required this.id,
    required this.number,
    required this.level,
  });

  factory GradeModel.fromRawJson(String str) =>
      GradeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        id: json["id"],
        number: json["numero"],
        level: LevelModel.fromJson(json["nivel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero": number,
        "nivel": level.toJson(),
      };
}
