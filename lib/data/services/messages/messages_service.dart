import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/conversation_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_send_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/recent_message_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/http/http_client.dart';
import 'package:colegio_bnnm/util/http/message_model.dart';
import 'package:image_picker/image_picker.dart';

class MessagesService {
  static String schoolUrl = APIConstants.schoolUrl;

  final _authRepository = AuthenticationRepository.instance;

  Future<List<dynamic>> getList(String url) async {
    return await _authRepository.responseValidatorServices(() async {
      final token = _authRepository.token();
      final urlList = "$schoolUrl$url";
      final response =
          await BHttpHelper.get(urlList, token: token, isList: true);
      if (url.contains(RecentConversationModel.urlList)) {
        if (url.contains("mensajes")) {
          return MessageListModel.fromJson(response).list();
        } else {
          return RecentMessageListModel.fromJson(response).list();
        }
      } else {
        return [];
      }
    });
  }

  Future<dynamic> getModel(String url) async {
    return await _authRepository.responseValidatorServices(() async {
      final token = _authRepository.token();
      final urlList = "$schoolUrl$url";
      final response = await BHttpHelper.get(urlList, token: token);
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else if (url.contains(RecentConversationModel.urlList)) {
        return ConversationModel.fromJson(response);
      }
    });
  }

  Future<List<MessageModel>> sendMessage(MessageSendModel message,
      {XFile? img}) async {
    return await _authRepository.responseValidatorServices(() async {
      final token = _authRepository.token();
      final urlSend = "$schoolUrl${MessageModel.urlList}";
      final response = await BHttpHelper.post(urlSend, message.toJson(),
          token: token, img: img, isList: true);
      if (response is! List && response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else {
        return MessageListModel.fromJson(response).list();
      }
    });
  }
}
