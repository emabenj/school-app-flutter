class GenderModel {
  static get url => "generos/";
  final int id;
  final String name;

  GenderModel({
    required this.id,
    required this.name,
  });
  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        id: json["id"],
        name: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
      };
}

class GenderListModel {
  final List<GenderModel> _genders;

  GenderListModel({required List<GenderModel> genders})
      : _genders = genders;

  factory GenderListModel.fromJson(List<Map<String, dynamic>> json) {
    return GenderListModel(
        genders: json.map((item) => GenderModel.fromJson(item)).toList());
  }

  List<GenderModel> list() {
    return _genders;
  }
}