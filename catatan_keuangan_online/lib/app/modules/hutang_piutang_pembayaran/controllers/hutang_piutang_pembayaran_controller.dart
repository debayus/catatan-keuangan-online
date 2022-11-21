import 'package:catatan_keuangan_online/app/models/hutang_piutang_pembayaran.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_config.dart';
import '../../../routes/app_pages.dart';

class HutangPiutangPembayaranController extends GetxController {
  final listCon = ListComponentController<HutangPiutangPembayaranModel>(
    urlApi: (index, filter) =>
        '/api/hutangpiutangpembayaran?page=$index&filter=$filter&id_hutang_piutang=${Get.parameters["id_hutang_piutang"]}',
    fromDynamic: HutangPiutangPembayaranModel.fromDynamic,
  );

  void addOnPress() {
    Get.toNamed(
      Routes.HUTANG_PIUTANG_PEMBAYARAN_SETUP,
      parameters: {
        'id_hutang_piutang': Get.parameters["id_hutang_piutang"]!,
      },
    )?.then((value) {
      if (value) {
        MahasConfig.refreshListHutangPiutang = true;
        MahasConfig.refreshListTransaksi = true;
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.HUTANG_PIUTANG_PEMBAYARAN_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )?.then((value) {
      if (value) {
        MahasConfig.refreshListHutangPiutang = true;
        MahasConfig.refreshListTransaksi = true;
        listCon.refresh();
      }
    });
  }
}
