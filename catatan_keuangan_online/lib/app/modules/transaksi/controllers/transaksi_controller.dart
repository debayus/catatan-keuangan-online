import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/services/helper.dart';
import '../../../models/transaksi_model.dart';

class TransaksiController extends GetxController {
  List<Widget> menus = [
    ListTile(
      onTap: () => Get.back(result: 'transaksi'),
      title: const Text("Transaksi"),
      leading: const Icon(FontAwesomeIcons.fileInvoiceDollar),
    ),
    const Divider(height: 0),
    ListTile(
      onTap: () => Get.back(result: 'mutasi rekening'),
      title: const Text("Mutasi Rekening"),
      leading: const Icon(FontAwesomeIcons.repeat),
    ),
    const Divider(height: 0),
    ListTile(
      onTap: () => Get.back(result: 'hutang piutang'),
      title: const Text("Hutang Piutang"),
      leading: const Icon(FontAwesomeIcons.repeat),
    ),
  ];

  void addOnPress() async {
    String? result = await Helper.modalMenu(menus);
    if (result == 'transaksi') {
      Get.toNamed(Routes.TRANSAKSI_SETUP);
    } else if (result == 'hutang piutang') {
      Get.toNamed(Routes.TRANSAKSI_SETUP);
    } else if (result == 'mutasi rekening') {
      Get.toNamed(Routes.TRANSAKSI_SETUP);
    }
  }

  IconData getIcon(String? jenis) {
    if (jenis == null) return FontAwesomeIcons.icons;
    return jenis == "Pemasukan"
        ? FontAwesomeIcons.handHoldingDollar
        : jenis == "Pengeluaran"
            ? FontAwesomeIcons.fileInvoiceDollar
            : jenis == "Hutang"
                ? FontAwesomeIcons.creditCard
                : jenis == "Piutang"
                    ? FontAwesomeIcons.creditCard
                    : FontAwesomeIcons.icons;
  }

  final listCon = ListComponentController<TransaksiModel>(
    urlApi: (index, filter) => '/api/transaksi?page=$index&filter=$filter',
    fromDynamic: TransaksiModel.fromDynamic,
    allowSearch: false,
  );

  void searchOnPress() {}
}
