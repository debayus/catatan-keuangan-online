import 'dart:convert';

import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_text_component.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../mahas/mahas_config.dart';
import '../../../routes/app_pages.dart';

class PengaturanRekeningSetupController extends GetxController {
  late SetupPageController formCon;
  final namaCon = InputTextController();
  final saldoCon = InputTextController(
    type: InputTextType.money,
  );
  var inputIcon = "".obs;

  void iconOnPress() async {
    if (EasyLoading.isShow) return;
    var r = await Get.toNamed(Routes.PENGATURAN_ICON);
    if (r != null) {
      inputIcon.value = (r as String);
    }
  }

  @override
  void onInit() {
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/rekening/$id',
      urlApiPost: () => '/api/rekening',
      urlApiPut: (id) => '/api/rekening/$id',
      urlApiDelete: (id) => '/api/rekening/$id',
      bodyApi: (id) => {
        'nama': namaCon.value,
        'icon': inputIcon.value,
        'saldo': saldoCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!namaCon.isValid) return false;
        if (inputIcon.isEmpty) {
          Helper.dialogWarning("Silahkan pilih icon");
          return false;
        }
        if (!saldoCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        var model = RekeningModel.fromJson(json);
        namaCon.value = model.nama;
        saldoCon.value = model.saldo;
        inputIcon.value = model.icon!;
      },
      allowDelete: MahasConfig.profile?.superUser == true,
      allowEdit: MahasConfig.profile?.superUser == true,
    );

    super.onInit();
  }
}
