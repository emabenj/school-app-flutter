class ImagenConversationModel {
  final String link;

  ImagenConversationModel({
    required this.link,
  });

  factory ImagenConversationModel.fromJson(Map<String, dynamic> json) {
    return ImagenConversationModel(
      link: json["imagen"],
    );
  }

  Map<String, dynamic> toJson() => {
        "imagen": link,
      };
}

class ImagenConversationListModel {
  final List<ImagenConversationModel> _imagenes;

  ImagenConversationListModel({required List<ImagenConversationModel> imagenes})
      : _imagenes = imagenes;

  factory ImagenConversationListModel.fromJson(List<dynamic> json) {
    return ImagenConversationListModel(
        imagenes: json
            .map((item) => ImagenConversationModel.fromJson(item))
            .toList());
  }

  List<Map<String, dynamic>> toJson() => _imagenes.map((e) => e.toJson()).toList();

  List<ImagenConversationModel> list() {
    return _imagenes;
  }
}
