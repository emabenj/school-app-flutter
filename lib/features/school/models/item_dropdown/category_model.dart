class CategoryModel {
  static String get url => "categorias/";
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });
  static CategoryModel empty() => CategoryModel(
      id: 0,
      name: "");

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
      };
}


class CategoryListModel {
  final List<CategoryModel> _categories;

  CategoryListModel({required List<CategoryModel> categories})
      : _categories = categories;

  factory CategoryListModel.fromJson(List<Map<String, dynamic>> json) {
    return CategoryListModel(
        categories: json.map((item) => CategoryModel.fromJson(item)).toList());
  }

  List<CategoryModel> list() {
    return _categories;
  }
}
