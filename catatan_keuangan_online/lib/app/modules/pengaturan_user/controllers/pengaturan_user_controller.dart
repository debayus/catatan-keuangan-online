import 'package:catatan_keuangan_online/app/models/user_model.dart';
import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../routes/app_pages.dart';

class PengaturanUserController extends GetxController {
  final listCon = ListComponentController<UserModel>(
    urlApi: (index, filter) => '/api/user?page=$index&filter=$filter',
    fromDynamic: UserModel.fromDynamic,
  );

  void addOnPress() {
    Get.toNamed(Routes.PENGATURAN_USER_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.PENGATURAN_USER_SETUP,
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
