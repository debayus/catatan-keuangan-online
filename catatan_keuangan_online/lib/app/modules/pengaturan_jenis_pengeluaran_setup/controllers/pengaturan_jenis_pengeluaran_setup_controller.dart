import 'dart:convert';

import 'package:catatan_keuangan_online/app/models/jenis_pengeluaran_pemasukan_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/helper.dart';
import '../../../routes/app_pages.dart';

class PengaturanJenisPengeluaranSetupController extends GetxController {
  late SetupPageController formCon;
  final namaCon = InputTextController();
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
      urlApiGet: (id) => '/api/jenispengeluaranpemasukan/$id',
      urlApiPost: () => '/api/jenispengeluaranpemasukan',
      urlApiPut: (id) => '/api/jenispengeluaranpemasukan/$id',
      urlApiDelete: (id) => '/api/jenispengeluaranpemasukan/$id',
      bodyApi: (id) => {
        'nama': namaCon.value,
        'icon': inputIcon.value,
        'pengeluaran': true,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!namaCon.isValid) return false;
        if (inputIcon.isEmpty) {
          Helper.dialogWarning("Silahkan pilih icon");
          return false;
        }
        return true;
      },
      apiToView: (json) {
        var model = JenisPengeluaranPemasukanModel.fromJson(json);
        namaCon.value = model.nama;
        inputIcon.value = model.icon!;
      },
      allowDelete: MahasConfig.profile?.superUser == true,
      allowEdit: MahasConfig.profile?.superUser == true,
    );

    super.onInit();
  }
}
