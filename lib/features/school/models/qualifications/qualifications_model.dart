class QualificationsModel {
  static String get url => "calificaciones/";
  final int id;
  double qualification1;
  double qualification2;
  double qualification3;
  double qualification4;
  double? average;

  static QualificationsModel empty() => QualificationsModel(
      id: 0,
      qualification1: 0,
      qualification2: 0,
      qualification3: 0,
      qualification4: 0,
      average: 0);

  QualificationsModel({
    required this.id,
    required this.qualification1,
    required this.qualification2,
    required this.qualification3,
    required this.qualification4,
    this.average,
  });

  factory QualificationsModel.fromJson(Map<String, dynamic> json) =>
      QualificationsModel(
        id: json["id"],
        qualification1: double.parse(json["calificacion1"]),
        qualification2: double.parse(json["calificacion2"]),
        qualification3: double.parse(json["calificacion3"]),
        qualification4: double.parse(json["calificacion4"]),
        average: double.parse(json["promedio"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "calificacion1": qualification1,
        "calificacion2": qualification2,
        "calificacion3": qualification3,
        "calificacion4": qualification4,
        "promedio": average,
      };
}

class QualificationsListModel {
  final List<QualificationsModel> _qualifications;

  QualificationsListModel({required List<QualificationsModel> qualifications})
      : _qualifications = qualifications;

  factory QualificationsListModel.fromJson(List<Map<String, dynamic>> json) {
    return QualificationsListModel(
        qualifications:
            json.map((item) => QualificationsModel.fromJson(item)).toList());
  }

  List<QualificationsModel> list() {
    return _qualifications;
  }
}
