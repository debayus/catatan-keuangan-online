import 'package:get/get.dart';

import '../controllers/xsample_date_time_controller.dart';

class XsampleDateTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleDateTimeController>(
      () => XsampleDateTimeController(),
    );
  }
}
