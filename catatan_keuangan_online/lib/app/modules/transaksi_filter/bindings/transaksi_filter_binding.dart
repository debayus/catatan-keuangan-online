import 'package:get/get.dart';

import '../controllers/transaksi_filter_controller.dart';

class TransaksiFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiFilterController>(
      () => TransaksiFilterController(),
    );
  }
}
