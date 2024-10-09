import 'package:colegio_bnnm/features/school/models/item_dropdown/homework_status_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';

class HomeworkEnumMapper {
  static const _homeworks = HomeworkStatus.values;
  static const _list = BTexts.homeworkList;
  final List<dynamic> _models;
  late TextEnumMapper mapper;

  HomeworkEnumMapper(this._models) {
    mapper = TextEnumMapper(_homeworks, _list, _models);
  }

  static HomeworkEnumMapper empty() => HomeworkEnumMapper(_homeworks);

  bool isUnderRevision(int id) {
    return HomeworkStatus.underRevision == mapper.getEnumById(id);
  }
  
  List<HomeworkStatusModel> list() {
    return mapper.list() as List<HomeworkStatusModel>;
  }
}
