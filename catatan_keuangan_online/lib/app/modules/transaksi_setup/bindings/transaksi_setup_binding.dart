import 'package:get/get.dart';

import '../controllers/transaksi_setup_controller.dart';

class TransaksiSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiSetupController>(
      () => TransaksiSetupController(),
    );
  }
}
