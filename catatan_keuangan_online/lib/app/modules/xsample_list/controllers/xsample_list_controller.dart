import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/text_model.dart';

class XsampleListController extends GetxController {
  final listCon = ListComponentController<TestModel>(
    urlApi: (index, filter) => '/api/test?page=$index&filter=$filter',
    fromDynamic: TestModel.fromDynamic,
  );

  void addOnPress() {
    Get.toNamed(Routes.XSAMPLE_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.XSAMPLE_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }
}
