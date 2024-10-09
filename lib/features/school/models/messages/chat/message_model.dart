import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/imagen_conversation_model.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';

class MessageModel {
  static String get urlList => "mensajes/";
  final int? id;
  final int conversation;
  final int transmitter;
  final int receiver;
  final String content;
  final List<ImagenConversationModel> imagenes;
  final DateTime? date;

  bool isRight() =>
      transmitter ==
      AuthenticationRepository.instance.currentUser()!.user.userId;

  String dateInChat() => BFormatter.formatDateChat(date!);
  String hourInRecentMessage() => BFormatter.formatHour(date!);

  MessageModel(
      {required this.id,
      required this.conversation,
      required this.transmitter,
      required this.receiver,
      required this.content,
      required this.imagenes,
      required this.date});

  bool likeAnother(MessageModel another) {
    return transmitter != another.receiver;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        conversation: json["conversacion"],
        transmitter: json["emisor"],
        receiver: json["receptor"],
        content: json["contenido"],
        imagenes: ImagenConversationListModel.fromJson(json["imagenes"]).list(),
        date: BFormatter.formatStringToDate(json["fecha_envio"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversacion": conversation,
        "emisor": transmitter,
        "receptor": receiver,
        "contenido": content,
        "imagenes": ImagenConversationListModel(imagenes: imagenes).toJson(),
        "fecha_envio": BFormatter.formatDateToString(date, normal: true),
      };
}

class MessageListModel {
  final List<MessageModel> _messages;

  MessageListModel({required List<MessageModel> messages})
      : _messages = messages;

  factory MessageListModel.fromJson(List<dynamic> json) {
    return MessageListModel(
        messages: json.map((item) => MessageModel.fromJson(item)).toList());
  }

  List<MessageModel> list() {
    return _messages;
  }
}
