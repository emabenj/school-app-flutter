import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';

class LevelEnumMapper {
  static const _levels = Levels.values;
  static const _list = BTexts.levelList;
  final List<dynamic> _models;
  late TextEnumMapper mapper;

  LevelEnumMapper(this._models) {
    mapper = TextEnumMapper(_levels, _list, _models);
  }

  static LevelEnumMapper empty() => LevelEnumMapper(_levels);
}
