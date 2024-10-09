import 'package:colegio_bnnm/util/abstract/text_enum_abstract.dart';

class TextEnumMapper extends TextToEnum {
  final List<Enum> _enums;
  final List<String> _spanish;
  final List<dynamic> _models;

  TextEnumMapper(this._enums, this._spanish, this._models)
      : assert(_enums.length == _spanish.length,
            'Las listas _enums y _spanish deben tener la misma longitud'),
        assert(_enums.length == _models.length,
            'Las listas _enums y _models deben tener la misma longitud');

  @override
  Enum getEnumById(int id) {
    return _enums[indexById(id)];
  }

  @override
  Enum getEnumByText(String text) {
    return _enums.byName(text);
  }

  @override
  getModelByEnum(Enum enum_) {
    return _models[indexByEnum(enum_)];
  }

  @override
  getModelById(int id) {
    return _models[indexById(id)];
  }

  @override
  getModelByText(String text) {
    return _models[indexByString(text)];
  }

  @override
  String getTextByEnum(Enum enum_) {
    return _spanish[indexByEnum(enum_)];
  }

  @override
  String getTextById(int id) {
    return _spanish[indexById(id)];
  }

  @override
  List<dynamic> list() {
    return _models;
  }

  @override
  int indexByEnum(Enum enum_) {
    return _enums.indexOf(enum_);
  }

  @override
  int indexById(int id) {
    return _models.indexWhere((model) => model.id == id);
  }

  @override
  int indexByString(String text) {
    return _spanish.indexOf(text);
  }
}
