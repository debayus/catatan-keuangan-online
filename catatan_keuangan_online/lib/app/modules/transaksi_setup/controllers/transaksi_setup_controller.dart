import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/models/jenis_pengeluaran_pemasukan_model.dart';
import 'package:catatan_keuangan_online/app/models/master_icon_model.dart';
import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';

class TransaksiSetupController extends GetxController {
  late SetupPageController formCon;

  late InputRadioController tipeCon;
  final rekeningCon = InputLookupController<RekeningModel>(
    urlApi: (pageIndex, filter) =>
        '/api/rekening?page=$pageIndex&filter=$filter',
    fromDynamic: RekeningModel.fromDynamic,
    itemText: (e) => e.nama ?? "",
    itemValue: (e) => e.id,
    itemBuilder: (e, onClick, color) => ListTile(
      tileColor: color,
      title: Text(e.nama ?? ""),
      trailing: Icon(MasterIconModel.getIcon(e.icon)),
      onTap: onClick,
    ),
  );
  late InputLookupController<JenisPengeluaranPemasukanModel> jenisCon;
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
    tipeCon = InputRadioController(
      items: [
        RadioButtonItem.autoId("Pengeluaran", 1),
        RadioButtonItem.autoId("Pemasukan", 0),
      ],
      onChanged: (item) {
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
        trailing: Icon(MasterIconModel.getIcon(e.icon)),
        onTap: onClick,
      ),
      beforeOnOpenModal: () {
        if (tipeCon.value == null) {
          Helper.dialogWarning("Tipe harus diisi");
          return false;
        } else {
          return true;
        }
      },
    );

    formCon = SetupPageController(
      urlApiGet: (id) => '/api/test/$id',
      urlApiPost: () => '/api/test',
      urlApiPut: (id) => '/api/test/$id',
      urlApiDelete: (id) => '/api/test/$id',
      bodyApi: (id) => {
        // 'name': nameCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!tipeCon.isValid) return false;
        if (!jenisCon.isValid) return false;
        if (!tanggalCon.isValid) return false;
        if (!rekeningCon.isValid) return false;
        if (!nilaiCon.isValid) return false;
        if (!catatanCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        // TestModel model = TestModel.fromJson(json);
        // nameCon.value = model.name;
      },
      onInit: () async {
        tanggalCon.value = DateTime.now();
        jamCon.value = TimeOfDay.fromDateTime(DateTime.now());
      },
    );

    super.onInit();
  }
}
