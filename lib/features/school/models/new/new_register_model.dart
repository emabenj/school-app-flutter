
class NewRegisterModel {
  static get url => "noticias/";
  final String title;
  final String content;
  final int category;
  final String? img;
  final int admin;

  NewRegisterModel({
    required this.title,
    required this.content,
    required this.category,
    required this.admin,
    this.img,
  });

  static NewRegisterModel empty() => NewRegisterModel(
      title: "",
      content: "",
      category: 0,
      img: "",
      admin: 0,);

  factory NewRegisterModel.fromJson(Map<String, dynamic> json) => NewRegisterModel(
      title: json["titulo"],
      content: json["descripcion"],
      category: json["categoria"],
      admin: json["administrador"]);

  Map<String, dynamic> toJson() => {
        "titulo": title,
        "descripcion": content,
        "categoria": category,
        "administrador": admin,
      };
}