import 'package:colegio_bnnm/util/formatters/formatter.dart';

class ConversationModel {
  final int id;
  final int firstParticipant;
  final int secondParticipant;
  final DateTime? creationDate;

  ConversationModel(
      {required this.id,
      required this.firstParticipant,
      required this.secondParticipant,
      this.creationDate});

  static ConversationModel empty() => ConversationModel(
      id: 0,
      firstParticipant: 0,
      secondParticipant: 0,
      creationDate: DateTime.now());

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json["id"],
        firstParticipant: json["participante_1"],
        secondParticipant: json["participante_2"],
        creationDate: BFormatter.formatStringToDate(json["fecha_creacion"])!,
      );

  Map<String, dynamic> toJson() => {
        "participante_1": firstParticipant,
        "participante_2": secondParticipant,
        "fecha_creacion": creationDate,
      };
}
