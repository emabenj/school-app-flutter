class RefreshToken {
  static String get url => "api/token/refresh/";
  final String refreshToken;

  RefreshToken({required this.refreshToken});

  // factory RefreshToken.fromJson(
  //         Map<String, dynamic> json, RefreshToken user) =>
  //     RefreshToken(
  //       refreshToken: json["refresh"],
  //     );
  Map<String, dynamic> toJson() => {
        "refresh": refreshToken,
      };
}
