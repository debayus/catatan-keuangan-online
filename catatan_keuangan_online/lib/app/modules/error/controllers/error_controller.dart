import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ErrorController extends GetxController {
  void kembaliOnPress() {
    Get.find<AuthController>().signOut();
  }
}
