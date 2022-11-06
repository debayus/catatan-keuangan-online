import 'package:catatan_keuangan_online/app/modules/grafik/controllers/grafik_controller.dart';
import 'package:catatan_keuangan_online/app/modules/hutang_piutang/controllers/hutang_piutang_controller.dart';
import 'package:catatan_keuangan_online/app/modules/pengaturan/controllers/pengaturan_controller.dart';
import 'package:flutter/material.dart';
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
      'icon': Icons.list,
    },
    {
      'label': 'Grafik',
      'icon': Icons.pie_chart,
    },
    {
      'label': 'Hutang Piutang',
      'icon': Icons.handshake_rounded,
    },
    {
      'label': 'Pengaturan',
      'icon': Icons.settings,
    },
  ];

  void bottomNavigationBarOnTab(v) {
    tabIndex.value = v;
  }
}
