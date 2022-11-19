import 'package:get/get.dart';

import '../controllers/hutang_piutang_pembayaran_controller.dart';

class HutangPiutangPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HutangPiutangPembayaranController>(
      () => HutangPiutangPembayaranController(),
    );
  }
}
