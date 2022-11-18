import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/master_icon_model.dart';
import '../../../models/mutasi_rekening_model.dart';
import '../../../models/rekening_model.dart';

class TransaksiMutasiRekeningController extends GetxController {
  late SetupPageController formCon;

  final rekeningDariCon = InputLookupController<RekeningModel>(
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
  final rekeningTujuanCon = InputLookupController<RekeningModel>(
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

  final tanggalCon = InputDatetimeController();
  final jamCon = InputDatetimeController();
  final nilaiCon = InputTextController(
    type: InputTextType.money,
  );
  final catatanCon = InputTextController(
    type: InputTextType.paragraf,
  );

  @override
  void onInit() {
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/mutasirekening/$id',
      urlApiPost: () => '/api/mutasirekening',
      urlApiPut: (id) => '/api/mutasirekening/$id',
      urlApiDelete: (id) => '/api/mutasirekening/$id',
      bodyApi: (id) => {
        'id_rekening_dari': rekeningDariCon.value!.id,
        'id_rekening_tujuan': rekeningTujuanCon.value!.id,
        'tanggal':
            "${MahasFormat.dateTimeOfDayToString(tanggalCon.value, jamCon.value)}",
        'nilai': nilaiCon.value,
        'catatan': catatanCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!tanggalCon.isValid) return false;
        if (!nilaiCon.isValid) return false;
        if (!catatanCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        MutasiRekeningModel model = MutasiRekeningModel.fromJson(json);
        tanggalCon.value = model.tanggal;
        jamCon.value = TimeOfDay.fromDateTime(model.tanggal!);
        rekeningDariCon.value =
            RekeningModel.init(model.idRekeningDari, model.idRekeningDariNama);
        rekeningTujuanCon.value = RekeningModel.init(
            model.idRekeningTujuan, model.idRekeningTujuanNama);
        nilaiCon.value = model.nilai;
        catatanCon.value = model.catatan;
      },
      onInit: () async {
        tanggalCon.value = DateTime.now();
        jamCon.value = TimeOfDay.fromDateTime(DateTime.now());
      },
    );

    super.onInit();
  }
}
