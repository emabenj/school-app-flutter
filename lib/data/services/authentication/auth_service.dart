import 'package:colegio_bnnm/features/authentication/models/login/new_access_token.dart';
import 'package:colegio_bnnm/features/authentication/models/login/refresh_token.dart';
import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';
import 'package:colegio_bnnm/features/authentication/models/login/user_login_model.dart';
import 'package:colegio_bnnm/util/http/http_client.dart';

class AuthService {
  UserAuthenticatedModel? actualUser;

  Future<UserAuthenticatedModel> signInWithEmailAndPassword(
      String email, String password) async {
    final user = UserLoginModel(email: email, password: password);
    final userAuth = UserAuthenticatedModel.fromJson(
        await BHttpHelper.post(UserLoginModel.url, user.toJson()));
    actualUser = userAuth;
    return userAuth;
  }

  Future<NewToken> refreshToken(String refreshToken) async {
    final refreshTokenModel = RefreshToken(refreshToken: refreshToken).toJson();
    final newAccessToken = NewToken.fromJson(
        await BHttpHelper.post(RefreshToken.url, refreshTokenModel));
    return newAccessToken;
  }
}
