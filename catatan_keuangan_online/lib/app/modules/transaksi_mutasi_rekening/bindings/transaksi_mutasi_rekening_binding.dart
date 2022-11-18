import 'package:get/get.dart';

import '../controllers/transaksi_mutasi_rekening_controller.dart';

class TransaksiMutasiRekeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiMutasiRekeningController>(
      () => TransaksiMutasiRekeningController(),
    );
  }
}
