import 'package:get/get.dart';

import '../controllers/trasaksi_controller.dart';

class TrasaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrasaksiController>(
      () => TrasaksiController(),
    );
  }
}
