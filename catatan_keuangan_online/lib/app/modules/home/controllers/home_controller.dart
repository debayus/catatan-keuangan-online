import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/modules/grafik/controllers/grafik_controller.dart';
import 'package:catatan_keuangan_online/app/modules/hutang_piutang/controllers/hutang_piutang_controller.dart';
import 'package:catatan_keuangan_online/app/modules/pengaturan/controllers/pengaturan_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../transaksi/controllers/transaksi_controller.dart';

class HomeController extends GetxController {
  var transaksiCon = Get.put(TransaksiController());
  var grafikCon = Get.put(GrafikController());
  var hutangPiutangCon = Get.put(HutangPiutangController());
  var pengaturanCon = Get.put(PengaturanController());

  var tabIndex = 0.obs;

  final List<Map<String, dynamic>> menus = [
    {
      'label': 'Transaksi',
      'icon': FontAwesomeIcons.list,
    },
    {
      'label': 'Grafik',
      'icon': FontAwesomeIcons.chartPie,
    },
    {
      'label': 'Hutang Piutang',
      'icon': FontAwesomeIcons.handshake,
    },
    {
      'label': 'Pengaturan',
      'icon': FontAwesomeIcons.gear,
    },
  ];

  void bottomNavigationBarOnTab(v) {
    tabIndex.value = v;
    if (v == 0) {
      if (MahasConfig.refreshListTransaksi) {
        transaksiCon.listCon.refresh();
        MahasConfig.refreshListTransaksi = false;
      }
    } else if (v == 1) {
      if (MahasConfig.refreshGrafik) {
        grafikCon.refreshData();
        MahasConfig.refreshGrafik = false;
      }
    } else if (v == 2) {
      if (MahasConfig.refreshListHutangPiutang) {
        hutangPiutangCon.listCon.refresh();
        MahasConfig.refreshListHutangPiutang = false;
      }
    }
  }
}
