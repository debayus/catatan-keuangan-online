import 'package:get/get.dart';

import '../controllers/pengaturan_rekening_controller.dart';

class PengaturanRekeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanRekeningController>(
      () => PengaturanRekeningController(),
    );
  }
}
