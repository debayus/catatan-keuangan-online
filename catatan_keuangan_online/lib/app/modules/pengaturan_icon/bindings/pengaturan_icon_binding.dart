import 'package:get/get.dart';

import '../controllers/pengaturan_icon_controller.dart';

class PengaturanIconBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanIconController>(
      () => PengaturanIconController(),
    );
  }
}
