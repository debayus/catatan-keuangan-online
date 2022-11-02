import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

final authController = AuthController.instance;
final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
final googleSign = GoogleSignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(hours: 1),
      minimumFetchInterval: const Duration(minutes: 2),
    ),
  );

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: const CircularProgressIndicator(),
    ),
  );
}
