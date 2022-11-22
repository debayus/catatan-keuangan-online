import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../models/hutang_piutang_model.dart';
import '../../../routes/app_pages.dart';

class HutangPiutangController extends GetxController {
  final listCon = ListComponentController<HutangPiutangModel>(
    urlApi: (index, filter) => '/api/hutangpiutang?page=$index&filter=$filter',
    fromDynamic: HutangPiutangModel.fromDynamic,
    allowSearch: false,
    autoRefresh: false,
  );

  void addOnPress() {
    Get.toNamed(Routes.HUTANG_PIUTANG_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
        MahasConfig.refreshListTransaksi = true;
        MahasConfig.refreshGrafik = true;
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.HUTANG_PIUTANG_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )?.then((value) {
      if (value) {
        listCon.refresh();
        MahasConfig.refreshGrafik = true;
        MahasConfig.refreshListTransaksi = true;
      }
    });
  }

  void itemPayOnTab(int id) {
    Get.toNamed(
      Routes.HUTANG_PIUTANG_PEMBAYARAN_SETUP,
      parameters: {
        'id_hutang_piutang': id.toString(),
      },
    )?.then((value) {
      if (value) {
        listCon.refresh();
        MahasConfig.refreshListTransaksi = true;
        MahasConfig.refreshGrafik = true;
      }
    });
  }

  void historyOnTab(int id) {
    Get.toNamed(
      Routes.HUTANG_PIUTANG_PEMBAYARAN,
      parameters: {
        'id_hutang_piutang': id.toString(),
      },
    )?.then((value) {
      if (MahasConfig.refreshListHutangPiutang) {
        listCon.refresh();
        MahasConfig.refreshListHutangPiutang = false;
      }
    });
  }
}
