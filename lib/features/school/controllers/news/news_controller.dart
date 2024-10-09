import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/screens/new/new_screen.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewsController extends GetxController {
  static NewsController get instance => Get.find();
  //VARIABLES
  final RxBool forA = false.obs;
  final model = NewModel.empty().obs;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final typeController = TextEditingController();
  final imgController = TextEditingController();
  XFile? imgFile;

  final news = RxList<NewModel>([]);

  final enabledButton = true.obs;
  GlobalKey<FormState> newsFormKey = GlobalKey<FormState>();
  //
  //
  void setModel(int index, {bool forDelet = false}) {
    model.value = news[index];
    if (!forDelet) {
      titleController.text = model.value.title;
      descriptionController.text = model.value.content;
      indexCategory.value = model.value.category;
      typeController.text = ItemListController
          .instance.newsCategory.value.mapper
          .getModelById(indexCategory.value)
          .name;
      Get.to(() => const NewsControlScreen());
    }
  }

  void setInsert() {
    statusCrud.value = Crud.insert;
    model.value = NewModel.empty();
    titleController.clear();
    descriptionController.clear();
    // selected.value = 0;
  }

  NewModel getModel() {
    return model.value;
  }

  void setModels(List<NewModel> newModels) {
    news.value = newModels;
  }

  Future<void> removeModel(int index) async {
    await AuthenticationRepository.instance.responseValidatorControllers(
        () async {
      if (isRemoving()) {
        await SchoolRepository.instance.deleteNew(model.value.id);
        news.removeAt(index);
      }
    }, titleMessage: "Error al eliminar la noticia");
  }

  //CATEGORIES
  final Rx<int> indexCategory = 0.obs;

  Future<void> actionCrud() async {
    await AuthenticationRepository.instance.responseValidatorControllers(
        () async {
      // FORM VALIDATION
      if (!newsFormKey.currentState!.validate() || enabledButton.isFalse) {
        return;
      }
      enabledButton.value = false;
      late String messageResponse;

      final idNew = model.value.id;
      // final viewsNew = model.value.views;
      final titleNew = titleController.text;
      final descriptionNew = descriptionController.text;
      final categoryNew = indexCategory.value;
      // final dateTimeNew = model.value.dateTime;
      final imgNew = imgController.text.isEmpty ? null : imgController.text;
      final adminNew = model.value.admin;
      if (isEditing()) {
        final newUpdated = await SchoolRepository.instance.editNew(idNew,
            titleNew, descriptionNew, categoryNew, adminNew, imgNew, imgFile);
        final indexEdit = news.indexWhere((new_) => new_.id == model.value.id);
        news[indexEdit] = newUpdated;
        messageResponse = "Noticia actualizada";
      } else {
        final newUpdated = await SchoolRepository.instance
            .addNew(titleNew, descriptionNew, categoryNew, imgFile);
        news.insert(0, newUpdated);
        messageResponse = "Noticia agregada";
      }
      setInsert();
      Get.back();
      BLoaders.successSnackBar(title: 'Éxito', message: messageResponse);
      enabledButton.value = true;
    }, titleMessage: "Error al Agregar/ Editar Noticia");
  }

  final Rx<Crud> statusCrud = Crud.insert.obs;

  bool isInserting() {
    return statusCrud.value == Crud.insert;
  }

  bool isEditing() {
    return statusCrud.value == Crud.edit;
  }

  bool isRemoving() {
    return statusCrud.value == Crud.remove;
  }
}
