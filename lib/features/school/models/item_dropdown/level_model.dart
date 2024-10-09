class LevelModel {
  static get url => "niveles/";
  final int id;
  final String name;

  LevelModel({
    required this.id,
    required this.name,
  });
  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
        id: json["id"],
        name: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
      };
}

class LevelListModel {
  final List<LevelModel> _levels;

  LevelListModel({required List<LevelModel> levels})
      : _levels = levels;

  factory LevelListModel.fromJson(List<Map<String, dynamic>> json) {
    return LevelListModel(
        levels: json.map((item) => LevelModel.fromJson(item)).toList());
  }

  List<LevelModel> list() {
    return _levels;
  }
}