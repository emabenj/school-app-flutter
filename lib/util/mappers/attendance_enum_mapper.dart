import 'package:colegio_bnnm/features/school/models/item_dropdown/attendance_status_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';

class AttendanceEnumMapper {
  static const _attendances = AttendanceStatus.values;
  static const _texts = BTexts.attendanceList;
  final List<dynamic> _models;
  late TextEnumMapper mapper;

  AttendanceEnumMapper(this._models) {
    mapper =
        TextEnumMapper(_attendances, _texts, _models);
  }

  static AttendanceEnumMapper empty() => AttendanceEnumMapper(_attendances);

  List<AttendanceStatusModel> listAttendanceToSelect() {
    final statusToSelect =
        mapper.list().sublist(0, _attendances.length - 1);
    return statusToSelect as List<AttendanceStatusModel>;
  }

  bool isRetired(int id) {
    return AttendanceStatus.retirated == mapper.getEnumById(id);
  }

  List<AttendanceStatusModel> list() {
    return mapper.list() as List<AttendanceStatusModel>;
  }
}
