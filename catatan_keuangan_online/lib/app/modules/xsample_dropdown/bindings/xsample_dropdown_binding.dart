import 'package:get/get.dart';

import '../controllers/xsample_dropdown_controller.dart';

class XsampleDropdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleDropdownController>(
      () => XsampleDropdownController(),
    );
  }
}
