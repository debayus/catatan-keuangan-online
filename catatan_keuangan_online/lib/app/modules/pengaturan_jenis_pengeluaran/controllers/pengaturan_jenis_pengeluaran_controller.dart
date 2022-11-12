import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../models/jenis_pengeluaran_pemasukan_model.dart';
import '../../../routes/app_pages.dart';

class PengaturanJenisPengeluaranController extends GetxController {
  final listCon = ListComponentController<JenisPengeluaranPemasukanModel>(
    urlApi: (index, filter) =>
        '/api/jenispengeluaranpemasukan?page=$index&filter=$filter&pengeluaran=1',
    fromDynamic: JenisPengeluaranPemasukanModel.fromDynamic,
  );

  void addOnPress() {
    Get.toNamed(Routes.PENGATURAN_JENIS_PENGELUARAN_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.PENGATURAN_JENIS_PENGELUARAN_SETUP,
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
