import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_dropdown_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/jenis_pengeluaran_pemasukan_model.dart';
import '../../../models/master_icon_model.dart';
import '../../../models/rekening_model.dart';

class TransaksiFilterController extends GetxController {
  var showJenis = false.obs;
  late InputDropdownController tipeCon;
  final rekeningCon = InputLookupController<RekeningModel>(
    urlApi: (pageIndex, filter) =>
        '/api/rekening?page=$pageIndex&filter=$filter',
    fromDynamic: RekeningModel.fromDynamic,
    itemText: (e) => e.nama ?? "",
    itemValue: (e) => e.id,
    itemBuilder: (e, onClick, color) => ListTile(
      tileColor: color,
      title: Text(e.nama ?? ""),
      leading: Icon(MasterIconModel.getIcon(e.icon)),
      subtitle: Text(MahasFormat.toCurrency(e.saldo)),
      onTap: onClick,
    ),
  );
  final dariTanggalCon = InputDatetimeController();
  final sampaiTanggalCon = InputDatetimeController();
  late InputLookupController<JenisPengeluaranPemasukanModel> jenisCon;

  void cariOnPress() {
    Get.back(result: true);
  }

  @override
  void onInit() {
    tipeCon = InputDropdownController(
      items: [
        DropdownItem.simple("Tampilkan Semua"),
        DropdownItem.simple("Pemasukan"),
        DropdownItem.simple("Pengeluaran"),
        DropdownItem.simple("Hutang"),
        DropdownItem.simple("Piutang"),
        DropdownItem.simple("Mutasi Rekening"),
      ],
      onChanged: (item) {
        showJenis.value =
            tipeCon.value == "Pengeluaran" || tipeCon.value == "Pemasukan";
        jenisCon.value = null;
      },
    );
    jenisCon = InputLookupController<JenisPengeluaranPemasukanModel>(
      urlApi: (pageIndex, filter) =>
          '/api/jenispengeluaranpemasukan?page=$pageIndex&filter=$filter&pengeluaran=${tipeCon.value}',
      fromDynamic: JenisPengeluaranPemasukanModel.fromDynamic,
      itemText: (e) => e.nama ?? "",
      itemValue: (e) => e.id,
      itemBuilder: (e, onClick, color) => ListTile(
        tileColor: color,
        title: Text(e.nama ?? ""),
        leading: Icon(MasterIconModel.getIcon(e.icon)),
        onTap: onClick,
      ),
    );

    dariTanggalCon.value = Get.arguments["dariTanggal"];
    sampaiTanggalCon.value = Get.arguments["sampaiTanggal"];
    rekeningCon.value = Get.arguments["rekening"];
    tipeCon.value = Get.arguments["tipe"] ?? "Tampilkan Semua";
    jenisCon.value = Get.arguments["jenis"];
    showJenis.value =
        tipeCon.value == "Pengeluaran" || tipeCon.value == "Pemasukan";
    super.onInit();
  }
}
