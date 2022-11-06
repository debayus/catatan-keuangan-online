import 'dart:convert';
import 'dart:math';
import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../mahas/services/mahas_service.dart';

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
      _toHome();
    }
  }

  void _toLigin() {
    Get.offAllNamed(Routes.LOGIN);
    MahasConfig.profile = null;
  }

  void _toHome() async {
    Get.offAllNamed(Routes.REGISTER);
    // var r = await HttpApi.get('/api/profile');
    // if (r.success) {
    //   MahasConfig.profile = ProfileModel.fromJson(r.body);
    //   if (Get.currentRoute != Routes.HOME) {
    //     Get.offAllNamed(Routes.HOME);
    //   }
    // } else {
    //   if (Get.currentRoute != Routes.ERROR) {
    //     Get.offAllNamed(Routes.ERROR);
    //   }
    // }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(credential);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
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

  Future signInWithApple() async {
    try {
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
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        Get.snackbar(
          "Error",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
