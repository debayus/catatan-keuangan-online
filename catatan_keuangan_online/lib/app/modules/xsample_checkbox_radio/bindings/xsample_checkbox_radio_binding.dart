import 'package:get/get.dart';

import '../controllers/xsample_checkbox_radio_controller.dart';

class XsampleCheckboxRadioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XsampleCheckboxRadioController>(
      () => XsampleCheckboxRadioController(),
    );
  }
}
