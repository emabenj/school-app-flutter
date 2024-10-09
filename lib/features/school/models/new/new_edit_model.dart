
class NewEditModel {
  static get url => "noticias/";
  final String title;
  final String content;
  final int category;
  final String? img;

  NewEditModel({
    required this.title,
    required this.content,
    required this.category,
    this.img,
  });

  static NewEditModel empty() => NewEditModel(
      title: "",
      content: "",
      category: 0,
      img: "",);

  factory NewEditModel.fromJson(Map<String, dynamic> json) => NewEditModel(
      title: json["titulo"],
      content: json["descripcion"],
      category: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": title,
        "descripcion": content,
        "categoria": category,
      };
}