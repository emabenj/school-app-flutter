class HomeworkStatusModel {
  static get url => "estados/tarea/";
  final int id;
  final String name;

  HomeworkStatusModel({
    required this.id,
    required this.name,
  });
  static HomeworkStatusModel empty() =>
      HomeworkStatusModel(id: 0, name: "");

  factory HomeworkStatusModel.fromJson(Map<String, dynamic> json) =>
      HomeworkStatusModel(
        id: json["id"],
        name: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
      };
}

class HomeworkStatusListModel {
  final List<HomeworkStatusModel> _statusList;

  HomeworkStatusListModel({required List<HomeworkStatusModel> statusList})
      : _statusList = statusList;

  factory HomeworkStatusListModel.fromJson(List<Map<String, dynamic>> json) {
    return HomeworkStatusListModel(
        statusList:
            json.map((item) => HomeworkStatusModel.fromJson(item)).toList());
  }

  List<HomeworkStatusModel> list() {
    return _statusList;
  }
}
