import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/hutang_piutang_pembayaran.dart';
import '../../../models/master_icon_model.dart';
import '../../../models/rekening_model.dart';

class HutangPiutangPembayaranController extends GetxController {
  late SetupPageController formCon;
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
      urlApiGet: (id) => '/api/hutangpiutangpembayaran/$id',
      urlApiPost: () => '/api/hutangpiutangpembayaran',
      urlApiPut: (id) => '/api/hutangpiutangpembayaran/$id',
      urlApiDelete: (id) => '/api/hutangpiutangpembayaran/$id',
      bodyApi: (id) => {
        'id_hutang_piutang': Get.parameters['id_hutang_piutang'],
        'id_rekening': rekeningCon.value!.id,
        'tanggal':
            "${MahasFormat.dateTimeOfDayToString(tanggalCon.value, jamCon.value)}",
        'nilai': nilaiCon.value,
        'catatan': catatanCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!tanggalCon.isValid) return false;
        if (!rekeningCon.isValid) return false;
        if (!nilaiCon.isValid) return false;
        if (!catatanCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        HutangPiutangPembayaranModel model =
            HutangPiutangPembayaranModel.fromJson(json);
        tanggalCon.value = model.tanggal;
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
