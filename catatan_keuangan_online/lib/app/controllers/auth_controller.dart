import 'dart:convert';
import 'dart:math';
import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/mahas/models/profile_model.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../mahas/mahas_service.dart';

class AuthController extends GetxController {
  final googleSign = GoogleSignIn();
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      _toLigin();
    } else {
      toHome();
    }
  }

  void _toLigin() {
    Get.offAllNamed(Routes.LOGIN);
    MahasConfig.profile = null;
  }

  void toHome() async {
    var r = await HttpApi.get('/api/auth');
    if (r.success) {
      MahasConfig.profile = ProfileModel.fromJson(r.body);
      if (Get.currentRoute != Routes.HOME) {
        Get.offAllNamed(Routes.HOME);
      }
    } else if (r.statusCode == 401) {
      if (Get.currentRoute != Routes.REGISTER) {
        Get.offAllNamed(Routes.REGISTER);
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
      Helper.dialogWarning(r.message);
    }
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  Future<UserCredential?> _signInWithCredentialGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
    if (googleSignInAccount == null) return null;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return await auth.signInWithCredential(credential);
  }

  void signInWithGoogle() async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    try {
      await _signInWithCredentialGoogle();
      final box = GetStorage();
      box.write('apple_login', null);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      await EasyLoading.dismiss();
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> _signInWithCredentialApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await auth.signInWithCredential(oauthCredential);
  }

  Future signInWithApple() async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    try {
      await _signInWithCredentialApple();
      final box = GetStorage();
      box.write('apple_login', true);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        Get.snackbar(
          "Error",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      await EasyLoading.dismiss();
    }
  }

  Future signOut() async {
    await auth.signOut();
    HttpApi.clearToken();
  }

  Future<void> deleteAccount() async {
    final box = GetStorage();
    UserCredential? userCredential;
    try {
      if (box.read('apple_login') == true) {
        userCredential = await _signInWithCredentialApple();
      } else {
        userCredential = await _signInWithCredentialGoogle();
      }
      if (userCredential?.user != null) {
        var r = await HttpApi.delete('/api/auth');
        if (r.success) {
        } else {
          Helper.dialogWarning(r.message);
          return;
        }
        await userCredential!.user!.delete();
      }
      auth.signOut();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        Get.snackbar(
          "Error",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
