class NewToken {
  final String accessToken;

  NewToken({required this.accessToken});

  
  factory NewToken.fromJson(
          Map<String, dynamic> json) =>
      NewToken(
        accessToken: json["access"],
      );
}
