import 'package:get/get.dart';

import '../controllers/hutang_piutang_pembayaran_setup_controller.dart';

class HutangPiutangPembayaranSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HutangPiutangPembayaranSetupController>(
      () => HutangPiutangPembayaranSetupController(),
    );
  }
}
