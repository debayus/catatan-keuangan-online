import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {
  var authCon = Get.find<AuthController>();

  void sampleOnPress() {
    Get.toNamed(Routes.XSAMPLE);
  }
}
