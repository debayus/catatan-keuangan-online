import 'package:get/get.dart';

import '../controllers/pengaturan_user_setup_controller.dart';

class PengaturanUserSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanUserSetupController>(
      () => PengaturanUserSetupController(),
    );
  }
}
