import 'package:get/get.dart';

import '../controllers/hutang_piutang_controller.dart';

class HutangPiutangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HutangPiutangController>(
      () => HutangPiutangController(),
    );
  }
}
