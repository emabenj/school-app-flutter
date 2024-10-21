import 'package:colegio_bnnm/app.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  if (!kIsWeb) { // Mobile only
    // Instance Widgets Binding
    final WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized();

    // -- Await Splash until other items Load
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  //-- Getx Local Storage
  await GetStorage.init();

  // --Initialize Authentication Repository
  Get.put(AuthenticationRepository());

  runApp(const App());
}

