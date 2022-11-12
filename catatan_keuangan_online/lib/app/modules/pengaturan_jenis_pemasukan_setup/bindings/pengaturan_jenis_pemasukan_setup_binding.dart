import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pemasukan_setup_controller.dart';

class PengaturanJenisPemasukanSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanJenisPemasukanSetupController>(
      () => PengaturanJenisPemasukanSetupController(),
    );
  }
}
