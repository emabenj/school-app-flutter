import 'package:colegio_bnnm/features/school/models/messages/chat/conversation_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';

class RecentConversationModel {
  static String get urlList => "conversaciones/";
  final ConversationModel conversation;
  MessageModel recentMessage;

  RecentConversationModel({
    required this.conversation,
    required this.recentMessage,
  });

  void updateRecentMessage(MessageModel newRecetMessage) {
    recentMessage = newRecetMessage;
  }

  String getRecentMessage() {
    final text = recentMessage.isRight()
        ? "Tú: ${recentMessage.content}"
        : recentMessage.content;
    final totalImgs = recentMessage.imagenes.length;
    final textWithImg = recentMessage.imagenes.isNotEmpty
        ? "($totalImgs imagenes) $text "
        : text;
    return textWithImg;
  }

  factory RecentConversationModel.fromJson(Map<String, dynamic> json) =>
      RecentConversationModel(
        conversation: ConversationModel.fromJson(json["conversacion"]),
        recentMessage: MessageModel.fromJson(json["mensaje_reciente"]),
      );
}

class RecentMessageListModel {
  final List<RecentConversationModel> _recentMessages;

  RecentMessageListModel(
      {required List<RecentConversationModel> recentMessages})
      : _recentMessages = recentMessages;

  factory RecentMessageListModel.fromJson(List<dynamic> json) {
    return RecentMessageListModel(
        recentMessages: json
            .map((item) => RecentConversationModel.fromJson(item))
            .toList());
  }

  List<RecentConversationModel> list() {
    return _recentMessages;
  }
}
