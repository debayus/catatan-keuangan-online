import 'package:get/get.dart';

import '../controllers/grafik_controller.dart';

class GrafikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrafikController>(
      () => GrafikController(),
    );
  }
}
