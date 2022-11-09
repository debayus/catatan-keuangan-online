import 'package:get/get.dart';

class PengaturanIconController extends GetxController {
  void iconOnPress(name) {
    Get.back(result: name);
  }
}
