import 'package:get/get.dart';

import '../controllers/xsample_list_controller.dart';

class XsampleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleListController>(
      () => XsampleListController(),
    );
  }
}
