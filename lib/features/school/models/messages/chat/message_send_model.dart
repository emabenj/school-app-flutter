
class MessageSendModel {
  // final int conversation;
  final int transmitter;
  final List<int> receivers;
  final String content;

  MessageSendModel(
      {
      // required this.conversation,
      required this.transmitter,
      required this.receivers,
      required this.content,
      });

  Map<String, dynamic> toJson() => {
        "emisor": transmitter,
        "receptores": receivers.join("."),
        // "conversacion": conversation,
        "contenido": content,
      };
}