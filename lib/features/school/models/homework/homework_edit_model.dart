class HomeworkEditModel {
  final String description;
  final String dueDate;

  HomeworkEditModel({
    required this.description,
  required this.dueDate,
  });

  factory HomeworkEditModel.fromJson(Map<String, dynamic> json) =>
      HomeworkEditModel(
        description: json["descripcion"],
        dueDate: json["fecha_entrega"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": description,
        "fecha_entrega": dueDate,
      };
}
