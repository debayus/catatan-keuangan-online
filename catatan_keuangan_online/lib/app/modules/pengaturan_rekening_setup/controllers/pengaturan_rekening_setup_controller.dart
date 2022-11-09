import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PengaturanRekeningSetupController extends GetxController {
  var inputNama = "".obs;
  var inputIcon = "".obs;

  void iconOnPress() async {
    var r = await Get.toNamed(Routes.PENGATURAN_ICON);
    if (r != null) {
      inputIcon.value = (r as String);
    }
  }

  void submitOnPress() {}
}
