import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class TrasaksiController extends GetxController {
  void showMessage() async {
    // var token = await auth.currentUser!.getIdToken(true);
    // print(token.substring(0, 400));
    // print(token.substring(400));
    Get.find<AuthController>().signOut();
  }
}
