import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';

class PengaturanRekeningController extends GetxController {
  final listCon = ListComponentController<RekeningModel>(
    urlApi: (index, filter) => '/api/rekening?page=$index&filter=$filter',
    fromDynamic: RekeningModel.fromDynamic,
  );

  void addOnPress() {
    Get.toNamed(Routes.PENGATURAN_REKENING_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.PENGATURAN_REKENING_SETUP,
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
