import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  void lanjutkanOnPress() async {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
    var r = await HttpApi.post('/api/auth');
    if (r.success) {
      Get.find<AuthController>().toHome();
    } else {
      EasyLoading.dismiss();
      Helper.dialogWarning(r.message);
    }
  }

  void kembaliOnPress() {
    Get.find<AuthController>().signOut();
  }
}
