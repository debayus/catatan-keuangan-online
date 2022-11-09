import 'package:get/get.dart';

import '../controllers/xsample_input_controller.dart';

class XsampleInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleInputController>(
      () => XsampleInputController(),
    );
  }
}
