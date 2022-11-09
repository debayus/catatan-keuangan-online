import 'dart:convert';

import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../models/rekening_model.dart';

class PengaturanRekeningController extends GetxController {
  var isLoading = false.obs;
  var isBottomLoading = false.obs;
  int pageIndex = 0;
  int maxPage = 0;
  var models = RxList<RekeningModel>();

  void addOnPress() {
    Get.toNamed(Routes.PENGATURAN_REKENING_SETUP);
  }

  Future<void> refreshModels({nextPage = false}) async {
    if (isLoading.isTrue) return;
    if (nextPage) {
      isBottomLoading.value = true;
    } else {
      models.clear();
      isLoading.value = true;
    }

    final pageIndexX = nextPage ? pageIndex + 1 : pageIndex;
    var r = await HttpApi.get('/api/rekening?pageIndex=$pageIndexX');

    if (r.success) {
      var jsonData = json.decode(r.body);
      maxPage = jsonData['totalRowCount'];
      pageIndex = pageIndexX;
      for (var obj in jsonData['data']['data']) {
        models.add(RekeningModel.fromDynamic(obj));
      }
    } else {
      Helper.dialogWarning(r.message);
    }

    if (nextPage) {
      isBottomLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    refreshModels();
  }
}
