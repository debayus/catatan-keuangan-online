import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {
  var authCon = Get.find<AuthController>();
  var version = "".obs;

  void sampleOnPress() {
    Get.toNamed(Routes.XSAMPLE);
  }

  @override
  void onInit() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    super.onInit();
  }
}
