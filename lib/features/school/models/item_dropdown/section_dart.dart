class SectionModel {
  final int id;
  final String name;

  SectionModel({
    required this.id,
    required this.name,
  });
  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        name: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
      };
}
