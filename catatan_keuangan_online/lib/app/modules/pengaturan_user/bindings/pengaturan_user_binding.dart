import 'package:get/get.dart';

import '../controllers/pengaturan_user_controller.dart';

class PengaturanUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanUserController>(
      () => PengaturanUserController(),
    );
  }
}
