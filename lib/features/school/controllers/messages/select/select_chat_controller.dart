import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/messages/messages_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/chat/chat_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/online_users_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/messages/select/recent_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/authorised_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/student_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/teacher_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/exceptions/api_auth_exceptions.dart';
import 'package:colegio_bnnm/util/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectChatController extends GetxController {
  static SelectChatController get instance => Get.find();
  final chatController = Get.put(ChatController());
  void loadData(List<dynamic> newModels) {
    parentsStudent.clear();
    parents.clear();
    teachers.clear();
    chatController.recentChatList.clear();

    if (isTeachersList()) {
      teachers.addAll(newModels as List<TeacherItemModel>);
    } else if (isSelecting()) {
      parentsStudent.addAll(newModels as List<StudentItemModel>);
      cleanPressedList();
      final parentIds = <int>{};

      for (var student in parentsStudent) {
        for (var parent in student.parents) {
          if (parentIds.add(parent.id)) {
            parents.add(parent);
          }
        }
      }
    }
    Get.put(RecenListController());
  }

  Future<void> loadRecentMessages() async {
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      final recentMessages =
          await MessagesRepository.instance.getRecentMessages();
      chatController.recentChatList.value = recentMessages;
    }, back: true, titleMessage: "Error al cargar mensajes recientes");
    RecenListController.instance.connectWebSockets();
  }

  //VARIABLES
  final parentsStudent = RxList<StudentItemModel>([]);
  final parents = RxList<AuthorisedItemModel>([]);
  final teachers = RxList<TeacherItemModel>([]);

  final isPressedList = <bool>[].obs; //Rx<List<bool>>([]);
  final allowSend = false.obs; //Rx<bool>(false);
  final countSend = 0.obs; //Rx<int>(0);

  final status = Rx<MessagesStatus>(MessagesStatus.selecting);
  final statusForTeacher = [MessagesStatus.sending, MessagesStatus.parentsList];
  String extraInfo = "";
  int groupId = 0;
  final textController = TextEditingController();
  GlobalKey<FormState> manyPeopleFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> onePersonFormKey = GlobalKey<FormState>();
  //
  //
  //
  void setStatus(MessagesStatus newStatus) {
    textController.clear();
    status.value = newStatus;
    if (isSelecting()) {
      cleanPressedList();
    }
  }

  void setUsersOnline(bool forT, void Function() onTap) {
    if (isTeachersList() || isAuthorisedsList()) {
      final onlineUserController = OnlineUserController.instance;
      final users = onlineUserController.getUsersOnlineByGroupId(groupId);

      final idUsers = users.map((e) => e.id).toList();
      final totalUsers = forT ? parents.length : teachers.length;
      for (var i = 0; i < totalUsers; i++) {
        final id = forT ? parents[i].id : teachers[i].id;
        final online = idUsers.contains(id);
        forT
            ? parents[i].changeStateOnline(online)
            : teachers[i].changeStateOnline(online);
        // ESTADO ONLINE DE USUARIO EN EL CHAT
        if ((onlineUserController.idUserChat ?? 0) == id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onlineUserController.onlineUserChat.value = online;
          });
        }
      }
    }
  }

  bool isSelecting() {
    return status.value == MessagesStatus.selecting;
  }

  bool isTeachersList() {
    return status.value == MessagesStatus.teachersList;
  }

  bool isAuthorisedsList() {
    return status.value == MessagesStatus.parentsList;
  }

  bool isSending() {
    return status.value == MessagesStatus.sending;
  }

  final List<int> receivers = [];
  Future<void> sendMessageToParents() async {
    try {
      //
      // CHECK INTERNET CONNECTIVITY
      //
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final text = textController.value.text;
      await chatController.sendMessageManyPeople(text, receivers);
      // Reiniciar estado de selección
      cleanPressedList();
      // REGRESAR A ESTADO DE ENVIAR
      setStatus(MessagesStatus.selecting);
    } catch (e) {
      late String messageError;
      if (e is BApiAuthException) {
        messageError = e.message;
      } else {
        messageError = e.toString();
      }
      BLoaders.errorSnackBar(
          title: "Error al enviar mensaje", message: messageError);
    }
  }

  List<dynamic> getModels() {
    return isSending()
        ? parentsStudent
        : isTeachersList()
            ? teachers
            : parents;
  }

  void changeStatusPressed(int index) {
    // Cambiar estado de selección del item StudentParent
    isPressedList[index] = !isPressedList[index];
    // Apoderados seleccionados
    final parents = parentsStudent[index].parents;
    // Filtrar para que no se repitan los Apoderados
    final parentsToAddOrRemove =
        parents.where((parent) => !receivers.contains(parent.id)).toList();
    // Agregar o eliminar los id de la lista de receptores
    final idsToAddOrRemove = parentsToAddOrRemove.map((e) => e.id);
    isPressedList[index]
        ? receivers.addAll(idsToAddOrRemove)
        : receivers.removeWhere((r) => idsToAddOrRemove.contains(r));
    // Aumentar o disminuir la cantidad de Apoderados seleccionados
    final totalParentsToAddOrRemove = parentsToAddOrRemove.length;
    isPressedList[index]
        ? countSend.value += totalParentsToAddOrRemove
        : countSend.value -= totalParentsToAddOrRemove;
    // Comprobar que hay más de 1 apoderado seleccionado
    allowSend.value = isPressedList.where((value) => value).length > 1;
  }

  void cleanPressedList() {
    isPressedList.value =
        List.generate(parentsStudent.length, (index) => false);
    allowSend.value = false;
    countSend.value = 0;
    receivers.clear();
    isPressedList.refresh();
  }

  UserItemModel getUserToRecentMessage(bool forT, int id) {
    final user = forT
        ? parents.firstWhereOrNull((element) => element.id == id)
        : teachers.firstWhereOrNull((element) => element.id == id);
    return user ?? UserItemModel.empty();
  }
}
