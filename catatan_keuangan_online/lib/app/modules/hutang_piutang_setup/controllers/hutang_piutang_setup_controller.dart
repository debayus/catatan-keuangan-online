import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/hutang_piutang_model.dart';
import '../../../models/master_icon_model.dart';
import '../../../models/rekening_model.dart';

class HutangPiutangSetupController extends GetxController {
  late SetupPageController formCon;

  final tipeCon = InputRadioController(
    items: [
      RadioButtonItem.autoId("Hutang", 1),
      RadioButtonItem.autoId("Piutang", 0),
    ],
  );
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
  final tanggalCon = InputDatetimeController();
  final tanggalTempoCon = InputDatetimeController();
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
      urlApiGet: (id) => '/api/hutangpiutang/$id',
      urlApiPost: () => '/api/hutangpiutang',
      urlApiPut: (id) => '/api/hutangpiutang/$id',
      urlApiDelete: (id) => '/api/hutangpiutang/$id',
      bodyApi: (id) => {
        'id_rekening': rekeningCon.value!.id,
        'tanggal':
            "${MahasFormat.dateTimeOfDayToString(tanggalCon.value, jamCon.value)}",
        'tanggal_tempo': "${MahasFormat.dateToString(tanggalTempoCon.value)}",
        'nilai': nilaiCon.value,
        'hutang': tipeCon.value,
        'catatan': catatanCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!tipeCon.isValid) return false;
        if (!tanggalCon.isValid) return false;
        if (!tanggalTempoCon.isValid) return false;
        if (!rekeningCon.isValid) return false;
        if (!nilaiCon.isValid) return false;
        if (!catatanCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        HutangPiutangModel model = HutangPiutangModel.fromJson(json);
        tipeCon.value = model.hutang == true ? 1 : 0;
        tanggalCon.value = model.tanggal;
        tanggalTempoCon.value = model.tanggalTempo;
        jamCon.value = TimeOfDay.fromDateTime(model.tanggal!);
        rekeningCon.value =
            RekeningModel.init(model.idRekening, model.idRekeningNama);
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
