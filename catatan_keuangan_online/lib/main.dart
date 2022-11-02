import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSign = GoogleSignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: const CircularProgressIndicator(),
    ),
  );
}
