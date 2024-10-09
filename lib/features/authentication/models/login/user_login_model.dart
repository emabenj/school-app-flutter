class UserLoginModel {
  static String get url => "login";
  final String email;
  final String password;

  UserLoginModel({
    required this.email,
    required this.password,
  });
  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
