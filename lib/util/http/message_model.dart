class MessageResponseModel {
  final String message;

  MessageResponseModel(this.message);

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      MessageResponseModel(json["message"]);
}
