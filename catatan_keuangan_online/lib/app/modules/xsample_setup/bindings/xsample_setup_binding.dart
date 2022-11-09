import 'package:get/get.dart';

import '../controllers/xsample_setup_controller.dart';

class XsampleSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleSetupController>(
      () => XsampleSetupController(),
    );
  }
}
