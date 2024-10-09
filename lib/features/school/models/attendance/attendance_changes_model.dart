class AttendanceChangesModel {
  final int attendanceId;
  final int status;
  AttendanceChangesModel({required this.attendanceId, required this.status});

  Map<String, dynamic> toJson() => {
        "id": attendanceId,
        "estado": status,
      };
}
