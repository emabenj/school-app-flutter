import 'dart:math';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class NewModel {
  static String get url => "noticias/";
  final _indexImg = Random().nextInt(3);
  final int id;
  final String title;
  final String content;
  int views;
  final int category;
  final String? img;
  final DateTime? dateTime;
  final int admin;

  NewModel({
    required this.id,
    required this.title,
    required this.views,
    required this.content,
    required this.category,
    required this.admin,
    this.img,
    this.dateTime,
  });
  String get formattedDateTime => BFormatter.formatDateToString(dateTime);

  String imgByType() {
    return ItemListController.instance.newsCategory.value
        .imgById(category, _indexImg);
  }

  String getImg() {
    return img??imgByType();
  }

  bool hasImg() {
    return img != null;
  }

  static NewModel empty() => NewModel(
      id: 0,
      title: "",
      views: 0,
      content: "",
      category: 0,
      img: "",
      admin: 0,
      dateTime: DateTime.now());

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
      id: json["id"],
      title: json["titulo"],
      views: json["vistas"],
      content: json["descripcion"],
      category: json["categoria"],
      img: json["imagen"],
      dateTime: BFormatter.formatStringToDate(json["fecha_publicacion"]),
      admin: json["administrador"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": title,
        "vistas": views,
        "descripcion": content,
        "categoria": category,
        "imagen": img,
        "fecha_publicacion": dateTime.toString(),
        "administrador": admin,
      };
}

class NewListModel {
  final List<NewModel> _news;

  NewListModel({required List<NewModel> news}) : _news = news;

  factory NewListModel.fromJson(List<Map<String, dynamic>> json) {
    return NewListModel(
        news: json.map((item) => NewModel.fromJson(item)).toList());
  }

  List<NewModel> list() {
    return _news;
  }
}
