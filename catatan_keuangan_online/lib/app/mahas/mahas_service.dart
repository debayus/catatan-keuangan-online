import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/auth_controller.dart';
import 'mahas_config.dart';

final authController = AuthController.instance;
final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();

class MahasService {
  static Future init() async {
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
    await remoteConfig.fetchAndActivate();
    if (MahasConfig.urlApi.isEmpty) {
      MahasConfig.urlApi = remoteConfig.getString('api');
    }
    await GetStorage.init();
  }
}
