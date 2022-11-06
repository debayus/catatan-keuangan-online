import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  void lanjutkanOnPress() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    var r = await HttpApi.post('/api/auth');
    if (r.success) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.defaultDialog(title: 'Error', middleText: r.message!);
    }
    isLoading.value = false;
  }
}
