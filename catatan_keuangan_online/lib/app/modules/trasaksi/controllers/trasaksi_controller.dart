import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TrasaksiController extends GetxController {
  void showMessage() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    print(token.substring(0, 400));
    print(token.substring(400));
  }
}
