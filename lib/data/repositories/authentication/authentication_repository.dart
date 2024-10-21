import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/services/authentication/auth_service.dart';
import 'package:colegio_bnnm/features/authentication/models/login/user_authenticated_model.dart';
import 'package:colegio_bnnm/features/authentication/screens/login/login_screen.dart';
import 'package:colegio_bnnm/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/navigation_menu.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/exceptions/api_auth_exceptions.dart';
import 'package:colegio_bnnm/util/helpers/calculator.dart';
import 'package:colegio_bnnm/util/helpers/network_manager.dart';
import 'package:colegio_bnnm/util/popups/full_screen_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  // VARIABLES
  final _storage = GetStorage();
  final _auth = AuthService();
  final Rx<bool> guestMode = false.obs;

  // Called from main.dart on app launch
  @override
  void onReady() {
    if (!kIsWeb) {
      FlutterNativeSplash.remove();
    }
    // INSTANCE Navigation Controller
    Get.put(NavigationController());
    // GO to screen
    screenRedirect();
  }

  UserAuthenticatedModel? currentUser() {
    return _auth.actualUser;
  }

  int userId() {
    return (currentUser() ?? UserAuthenticatedModel.empty()).user.userId;
  }

  int roleId() {
    return (currentUser() ?? UserAuthenticatedModel.empty()).user.id;
  }

  String token() {
    return (currentUser() ?? UserAuthenticatedModel.empty()).accessToken;
  }

  bool allowToUpdateDetails() {
    return BCalculator.hasPassedOneMonth(
        (currentUser() ?? UserAuthenticatedModel.empty())
            .user
            .lastProfileUpdated);
  }

  // Function to Show Relevant Screen
  Future<void> screenRedirect() async {
    if (guestMode.isFalse &&
        _storage.read(BTexts.keyRememberEmail) != null &&
        _storage.read(BTexts.keyRememberPass) != null) {
      String email = _storage.read(BTexts.keyRememberEmail);
      String pass = _storage.read(BTexts.keyRememberPass);
      await loginWithEmailAndPassword(email, pass, verifyInternet: true);
    }
    if (currentUser() != null || guestMode.isTrue) {
      guestMode.value = false;
      NavigationController.instance.setUser(currentUser()!);
      Get.offAll(() => const NavigationMenu());
    } else {
      _storage.writeIfNull(BTexts.keyFirstTime, true);
      _storage.read(BTexts.keyFirstTime) != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  //LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password,
      {bool verifyInternet = false}) async {
    try {
      // CHECK INTERNET CONNECTIVITY
      final isConnected =
          verifyInternet ? await NetworkManager.instance.isConnected() : true;
      if (!isConnected) return;
      await _auth.signInWithEmailAndPassword(email, password);
    } catch (e) {
      String messageError = "$e";
      if (e is ClientException) {
        messageError = BTexts.noServerConnectionMessage;
      } else if (e is BApiAuthException) {
        throw BApiAuthException(e.message);
      }
      BLoaders.warningSnackBar(
          title: BTexts.noServerConnectionTitle, message: messageError);
      if (!verifyInternet) {
        throw Exception(null);
      }
    }
  }

  Future<void> loginOut() async {
    _auth.actualUser = guestMode.isTrue ? UserAuthenticatedModel.empty() : null;
    _storage.write(BTexts.keyRememberEmail, null);
    _storage.write(BTexts.keyRememberPass, null);
    _storage.write(BTexts.keyRememberRole, null);
    screenRedirect();
  }

  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = currentUser()!.refreshToken;
      final response = await _auth.refreshToken(refreshToken);
      final newAccessToken = response.accessToken;
      currentUser()!.setNewAccessToken(newAccessToken);
      return true;
    } catch (e) {
      loginOut();
      return false;
    }
  }

  // VALIDATION of responses in the services
  Future<dynamic> responseValidatorServices(
      Future<dynamic> Function() response) async {
    try {
      return await response();
    } catch (e) {
      if ("$e".contains("Refresh token")) {
        final tryAgain = await refreshAccessToken();
        if (tryAgain) {
          return await responseValidatorServices(response);
        } else {
          throw BApiAuthException(BTexts.sessionClosed);
        }
      }
      rethrow;
    }
  }

  // VALIDATION of respones in controllers
  Future<void> responseValidatorControllers(Future<void> Function() response,
      {String titleMessage = "Oh Snap!",
      bool fullScreenLoader = false,
      bool back = false}) async {
    try {
      // INTERNET connection validation
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;
      await response();
    } catch (e) {
      print("$e");
      // If the loading screen has been set
      if (fullScreenLoader) BFullScreenLoader.stopLoading();
      String messageError = "$e";
      if (e is BApiAuthException) {
        messageError = e.message;
      } else if (e is ClientException) {
        messageError = BTexts.noServerConnectionMessage;
        if (back) Get.back();
        BLoaders.warningSnackBar(
            title: BTexts.titleNoServerConnection, message: messageError);
        return;
      }
      if (back) Get.back();
      messageError = messageError.replaceAll("Exception: ", "");
      BLoaders.errorSnackBar(title: titleMessage, message: messageError);
    }
  }
}
