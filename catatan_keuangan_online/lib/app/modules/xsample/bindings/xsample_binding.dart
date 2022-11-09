import 'package:get/get.dart';

import '../controllers/xsample_controller.dart';

class XsampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleController>(
      () => XsampleController(),
    );
  }
}
