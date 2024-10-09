import 'package:colegio_bnnm/features/school/models/item_dropdown/gender_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';

class GenderEnumMapper {
  static const _genders = Genders.values;
  static const _texts = BTexts.genderList;
  final List<dynamic> _models;
  late TextEnumMapper mapper;

  static const _images = [BImages.male, BImages.female];

  GenderEnumMapper(this._models) {
    mapper = TextEnumMapper(_genders, _texts, _models);
  }

  static GenderEnumMapper empty() => GenderEnumMapper(_genders);

  String getImg(int id) {
    return _images[mapper.indexById(id)];
  }

  List<GenderModel> list() {
    return mapper.list() as List<GenderModel>;
  }
}
