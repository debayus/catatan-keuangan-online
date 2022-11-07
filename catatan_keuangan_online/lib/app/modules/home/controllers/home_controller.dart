import 'package:catatan_keuangan_online/app/modules/grafik/controllers/grafik_controller.dart';
import 'package:catatan_keuangan_online/app/modules/hutang_piutang/controllers/hutang_piutang_controller.dart';
import 'package:catatan_keuangan_online/app/modules/pengaturan/controllers/pengaturan_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../trasaksi/controllers/trasaksi_controller.dart';

class HomeController extends GetxController {
  var transaksiCon = Get.put(TrasaksiController());
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
  }
}
