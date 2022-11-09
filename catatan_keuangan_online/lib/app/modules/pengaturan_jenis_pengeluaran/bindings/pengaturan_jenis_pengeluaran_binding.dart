import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pengeluaran_controller.dart';

class PengaturanJenisPengeluaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanJenisPengeluaranController>(
      () => PengaturanJenisPengeluaranController(),
    );
  }
}
