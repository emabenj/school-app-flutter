class DetailModel {
  final String detail;

  DetailModel(this.detail);

  factory DetailModel.fromJson(Map<String, dynamic> json) =>
      DetailModel(json["details"]);
}
