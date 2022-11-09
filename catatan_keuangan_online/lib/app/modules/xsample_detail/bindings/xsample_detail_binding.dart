import 'package:get/get.dart';

import '../controllers/xsample_detail_controller.dart';

class XsampleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleDetailController>(
      () => XsampleDetailController(),
    );
  }
}
