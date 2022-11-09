import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_text_component.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PengaturanRekeningSetupController extends GetxController {
  var namaCon = InputTextController();
  var saldoCon = InputTextController(
    type: InputTextType.money,
  );

  var inputNama = "".obs;
  var inputIcon = "".obs;

  void iconOnPress() async {
    var r = await Get.toNamed(Routes.PENGATURAN_ICON);
    if (r != null) {
      inputIcon.value = (r as String);
    }
  }

  void saldoOnChanged(String value) {}

  void submitOnPress() {}
}
