import 'package:get/get.dart';

import '../controllers/pengaturan_rekening_setup_controller.dart';

class PengaturanRekeningSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanRekeningSetupController>(
      () => PengaturanRekeningSetupController(),
    );
  }
}
