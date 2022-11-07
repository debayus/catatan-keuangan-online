import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  void lanjutkanOnPress() async {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
    var r = await HttpApi.post('/api/auth');
    if (r.success) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.defaultDialog(title: 'Error', middleText: r.message!);
    }
    EasyLoading.dismiss();
  }

  void kembaliOnPress() {
    Get.find<AuthController>().signOut();
  }
}
