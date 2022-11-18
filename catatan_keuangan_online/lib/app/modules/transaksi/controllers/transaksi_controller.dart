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
      leading: const Icon(FontAwesomeIcons.handshake),
    ),
  ];

  void addOnPress() async {
    String? result = await Helper.modalMenu(menus);
    bool? refresh = false;
    if (result == 'transaksi') {
      refresh = await Get.toNamed(Routes.TRANSAKSI_SETUP);
    } else if (result == 'mutasi rekening') {
      refresh = await Get.toNamed(Routes.TRANSAKSI_MUTASI_REKENING);
    } else if (result == 'hutang piutang') {}
    if (refresh == true) {
      listCon.refresh();
    }
  }

  IconData getIcon(String? tipe) {
    if (tipe == null) return FontAwesomeIcons.icons;
    return tipe == "Pemasukan"
        ? FontAwesomeIcons.handHoldingDollar
        : tipe == "Pengeluaran"
            ? FontAwesomeIcons.fileInvoiceDollar
            : tipe == "Hutang"
                ? FontAwesomeIcons.creditCard
                : tipe == "Piutang"
                    ? FontAwesomeIcons.creditCard
                    : tipe == "Mutasi Rekening"
                        ? FontAwesomeIcons.creditCard
                        : FontAwesomeIcons.icons;
  }

  final listCon = ListComponentController<TransaksiModel>(
    urlApi: (index, filter) => '/api/transaksi?page=$index&filter=$filter',
    fromDynamic: TransaksiModel.fromDynamic,
    allowSearch: false,
  );

  void itemOnTab(TransaksiModel model) async {
    bool? refresh = false;
    if (model.tipe == "Pemasukan" || model.tipe == "Pengeluaran") {
      refresh = await Get.toNamed(
        Routes.TRANSAKSI_SETUP,
        parameters: {
          'id': model.id.toString(),
        },
      );
    } else if (model.tipe == "Mutasi Rekening") {
      refresh = await Get.toNamed(
        Routes.TRANSAKSI_MUTASI_REKENING,
        parameters: {
          'id': model.id.toString(),
        },
      );
    }
    if (refresh == true) {
      listCon.refresh();
    }
  }

  void searchOnPress() {}
}
