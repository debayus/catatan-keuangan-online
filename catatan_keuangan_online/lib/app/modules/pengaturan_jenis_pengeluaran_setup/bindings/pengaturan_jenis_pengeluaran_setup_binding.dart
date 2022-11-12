import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pengeluaran_setup_controller.dart';

class PengaturanJenisPengeluaranSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanJenisPengeluaranSetupController>(
      () => PengaturanJenisPengeluaranSetupController(),
    );
  }
}
