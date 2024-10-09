import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/services/messages/messages_service.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/conversation_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_send_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/recent_message_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessagesRepository extends GetxController {
  static MessagesRepository get instance => Get.find();
  final _messages = MessagesService();

  Future<List<RecentConversationModel>> getRecentMessages() async {
    final urlList = RecentConversationModel.urlList;
    final recentMessagesList =
        await _messages.getList(urlList) as List<RecentConversationModel>;
    return recentMessagesList;
  }

  Future<ConversationModel> getConversation(int receiverId) async {
    final urlGet =
        "${RecentConversationModel.urlList}0?participante_2=$receiverId";
    final conversation = await _messages.getModel(urlGet) as ConversationModel;
    return conversation;
  }

  Future<List<MessageModel>> getMessages(int conversationId) async {
    final urlList =
        "${RecentConversationModel.urlList}$conversationId/${MessageModel.urlList}";
    final messagesConversation =
        await _messages.getList(urlList) as List<MessageModel>;
    return messagesConversation;
  }

  Future<MessageModel> sendMessageToOnePerson(
      int receiver, String content, XFile? img) async {
    final transmitterId = AuthenticationRepository.instance.userId();
    final model = MessageSendModel(
        transmitter: transmitterId, receivers: [receiver], content: content);
    final messagesConversations = await _messages.sendMessage(model, img: img);
    final messageConversation = messagesConversations[0];
    return messageConversation;
  }

  Future<List<MessageModel>> sendMessageToManyPeople(
      List<int> receivers, String content, XFile? img) async {
    final transmitterId = AuthenticationRepository.instance.userId();
    final model = MessageSendModel(
        transmitter: transmitterId, receivers: receivers, content: content);
    final messagesConversations = await _messages.sendMessage(model, img: img);
    return messagesConversations;
  }
}
