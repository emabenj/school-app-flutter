import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/authorised_item_model.dart';
import 'package:colegio_bnnm/features/school/models/select/select_model.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class StudentItemModel extends UserItemModel {
  final int gender;
  final List<AuthorisedItemModel> parents;

  StudentItemModel(
      {required super.id,
      required super.name,
      required super.lastname,
      required this.gender,
      required this.parents});
  @override
  String getImg() => ItemListController.instance.gender.value.getImg(gender);
  @override
  String getText() => BFormatter.formatName(name, lastname, onlyName: true);

  factory StudentItemModel.fromJson(Map<String, dynamic> json) =>
      StudentItemModel(
        id: json["id"],
        name: json["nombres"],
        lastname: json["apellidos"],
        gender: json["genero"],
        parents: AuthorisedListModel.fromJson(json["apoderados"]).list(),
      );

  SelectModel select() => SelectModel(title: name, subTitle: lastname, stateUsers: "");

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "nombres": name,
  //     "apellidos": lastname,
  //     "genero": gender,
  //     "apoderados": parents,
  // };
}

class StudentItemListModel {
  final List<StudentItemModel> _students;

  StudentItemListModel({required List<StudentItemModel> students})
      : _students = students;

  factory StudentItemListModel.fromJson(List<dynamic> json) {
    return StudentItemListModel(
        students: json.map((item) => StudentItemModel.fromJson(item)).toList());
  }

  List<StudentItemModel> list() {
    return _students;
  }
}
