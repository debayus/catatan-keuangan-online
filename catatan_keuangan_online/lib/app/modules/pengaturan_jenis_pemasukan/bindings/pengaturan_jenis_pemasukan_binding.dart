import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pemasukan_controller.dart';

class PengaturanJenisPemasukanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanJenisPemasukanController>(
      () => PengaturanJenisPemasukanController(),
    );
  }
}
