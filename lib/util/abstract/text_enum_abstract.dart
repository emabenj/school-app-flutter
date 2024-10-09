abstract class TextToEnum {
  List<dynamic> list();

  dynamic getModelByText(String text);
  dynamic getModelById(int id);
  dynamic getModelByEnum(Enum enum_);

  String getTextByEnum(Enum enum_);
  String getTextById(int id);

  Enum getEnumById(int id);
  Enum getEnumByText(String text);

  int indexByEnum(Enum enum_);
  int indexByString(String text);
  int indexById(int id);
}
