import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:catatan_keuangan_online/app/models/jenis_pengeluaran_pemasukan_model.dart';
import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:catatan_keuangan_online/app/modules/transaksi_filter/controllers/transaksi_filter_controller.dart';
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
      MahasConfig.refreshGrafik = true;
    }
  }

  IconData getIcon(String? tipe) {
    if (tipe == null) return FontAwesomeIcons.icons;
    return tipe == "Pemasukan"
        ? FontAwesomeIcons.handHoldingDollar
        : tipe == "Pengeluaran"
            ? FontAwesomeIcons.fileInvoiceDollar
            : tipe == "Hutang Piutang"
                ? FontAwesomeIcons.handshake
                : tipe == "Mutasi Rekening"
                    ? FontAwesomeIcons.creditCard
                    : tipe == "Pembayaran Hutang Piutang"
                        ? FontAwesomeIcons.moneyBillWave
                        : FontAwesomeIcons.icons;
  }

  DateTime? filterDariTanggal;
  DateTime? filterSampaiTanggal;
  RekeningModel? filterRekening;
  String? filterTipe;
  JenisPengeluaranPemasukanModel? filterJenis;

  late ListComponentController<TransaksiModel> listCon;

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
    } else if (model.tipe == "Hutang Piutang") {
      refresh = await Get.toNamed(
        Routes.HUTANG_PIUTANG_SETUP,
        parameters: {
          'id': model.id.toString(),
        },
      );
    } else if (model.tipe == "Pembayaran Hutang Piutang") {
      refresh = await Get.toNamed(
        Routes.HUTANG_PIUTANG_PEMBAYARAN_SETUP,
        parameters: {
          'id': model.id.toString(),
        },
      );
    }
    if (refresh == true) {
      listCon.refresh();
      MahasConfig.refreshGrafik = true;
    }
  }

  void cariOnPress() async {
    var refresh = await Get.toNamed(Routes.TRANSAKSI_FILTER, arguments: {
      "dariTanggal": filterDariTanggal,
      "sampaiTanggal": filterSampaiTanggal,
      "rekening": filterRekening,
      "tipe": filterTipe,
      "jenis": filterJenis
    });
    if (refresh == true) {
      var transaksiFilterCon = Get.find<TransaksiFilterController>();
      filterDariTanggal = transaksiFilterCon.dariTanggalCon.value;
      filterSampaiTanggal = transaksiFilterCon.sampaiTanggalCon.value;
      filterRekening = transaksiFilterCon.rekeningCon.value;
      filterTipe = transaksiFilterCon.tipeCon.value;
      filterJenis = transaksiFilterCon.jenisCon.value;
      listCon.refresh();
      MahasConfig.refreshGrafik = true;
    }
  }

  @override
  void onInit() {
    listCon = ListComponentController<TransaksiModel>(
      urlApi: (index, filter) {
        var url = '/api/transaksi?page=$index';
        if (filterDariTanggal != null) {
          url += '&dari_tanggal=${MahasFormat.dateToString(filterDariTanggal)}';
        }
        if (filterSampaiTanggal != null) {
          url +=
              '&sampai_tanggal=${MahasFormat.dateToString(filterSampaiTanggal)}';
        }
        if (filterRekening != null) {
          url += '&rekening=${filterRekening!.id}';
        }
        if (filterTipe != null && filterTipe != "Tampilkan Semua") {
          url += '&tipe=$filterTipe';
        }
        if (filterJenis != null) {
          url += '&jenis=${filterJenis!.id}';
        }
        return url;
      },
      fromDynamic: TransaksiModel.fromDynamic,
      allowSearch: false,
    );
    super.onInit();
  }
}
