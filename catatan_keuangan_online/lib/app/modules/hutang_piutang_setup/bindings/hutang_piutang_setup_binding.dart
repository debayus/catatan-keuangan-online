import 'package:get/get.dart';

import '../controllers/hutang_piutang_setup_controller.dart';

class HutangPiutangSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HutangPiutangSetupController>(
      () => HutangPiutangSetupController(),
    );
  }
}
