import 'package:colegio_bnnm/features/school/models/item_dropdown/category_model.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/mappers/text_enum_mapper.dart';

class NewsCategoryEnumMapper {
  static const _categories = NewCategory.values; //CHANGE
  static const _texts = BTexts.categories;
  final List<dynamic> _models;

  late TextEnumMapper mapper;

  NewsCategoryEnumMapper(this._models) {
    mapper = TextEnumMapper(_categories, _texts, _models);
  }

  static NewsCategoryEnumMapper empty() => NewsCategoryEnumMapper(_categories);

  List<CategoryModel> list() {
    return mapper.list() as List<CategoryModel>;
  }

  String imgById(int id, int random) {
    return "assets/images/new_${mapper.indexById(id) + 1}_${random + 1}.jpg";
  }

  // CategoryModel getCategory(int id) {
  //   return getCategories().firstWhereOrNull((cat) => cat.id == id) ??
  //       CategoryModel.empty();
  // }

  // int getCategoryIndex(int id) {
  //   final categoryList = getCategories();
  //   return categoryList.indexWhere((cat) => cat.id == id);
  // }
}

enum NewCategory { cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9 }
