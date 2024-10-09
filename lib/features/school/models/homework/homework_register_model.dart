class HomeworkRegisterModel {
  final int classroomId;
  final int teacherId;
  final String description;
  final String dueDate;
  final int status;

  HomeworkRegisterModel({
    required this.classroomId,
    required this.teacherId,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    // List<int>.from(json["estudiantes"].map((x) => x))
        "aulas": List<int>.from([classroomId]),
        "docente": teacherId,
        "descripcion": description,
        "fecha_entrega": dueDate,
        "estado": status,
      };
}
