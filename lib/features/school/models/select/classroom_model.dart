class ClassroomModel {
  final int id;
  final String? name;
  final String? grade;
  final String? section;

  String getRoom() => "$name - $grade - '$section'";

  ClassroomModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.section,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json["id"],
        name: json["nombre"],
        grade: json["grado"],
        section: json["seccion"],
      );
}
