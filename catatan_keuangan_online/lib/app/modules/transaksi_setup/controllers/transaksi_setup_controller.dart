import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
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
import '../../../models/pengeluaran_pemasukan_model.dart';
import '../../../models/user_model.dart';

class TransaksiSetupController extends GetxController {
  late SetupPageController formCon;

  final userCon = InputLookupController<UserModel>(
    urlApi: (pageIndex, filter) =>
        '/api/pengeluaranpemasukan/user?page=$pageIndex&filter=$filter',
    fromDynamic: UserModel.fromDynamic,
    itemText: (e) => e.nama ?? "",
    itemValue: (e) => e.id,
  );
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
      leading: Icon(MasterIconModel.getIcon(e.icon)),
      subtitle: Text(MahasFormat.toCurrency(e.saldo)),
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
        leading: Icon(MasterIconModel.getIcon(e.icon)),
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
      urlApiGet: (id) => '/api/pengeluaranpemasukan/$id',
      urlApiPost: () => '/api/pengeluaranpemasukan',
      urlApiPut: (id) => '/api/pengeluaranpemasukan/$id',
      urlApiDelete: (id) => '/api/pengeluaranpemasukan/$id',
      bodyApi: (id) => {
        'id_user': userCon.value?.id,
        'id_jenis_pengeluaran_pemasukan': jenisCon.value!.id,
        'id_rekening': rekeningCon.value!.id,
        'tanggal':
            "${MahasFormat.dateTimeOfDayToString(tanggalCon.value, jamCon.value)}",
        'nilai': nilaiCon.value,
        'catatan': catatanCon.value,
        'pengeluaran': tipeCon.value
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!userCon.isValid) return false;
        if (!tipeCon.isValid) return false;
        if (!jenisCon.isValid) return false;
        if (!tanggalCon.isValid) return false;
        if (!rekeningCon.isValid) return false;
        if (!nilaiCon.isValid) return false;
        if (!catatanCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        PengeluaranPemasukanModel model =
            PengeluaranPemasukanModel.fromJson(json);
        userCon.value = UserModel.init(model.idUser, model.idUserNama);
        tipeCon.value = model.pengeluaran == true ? 1 : 0;
        jenisCon.value = JenisPengeluaranPemasukanModel.init(
            model.idJenisPengeluaranPemasukan,
            model.idJenisPengeluaranPemasukanNama);
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
        userCon.value =
            UserModel.init(MahasConfig.profile!.id, MahasConfig.profile!.nama);
      },
    );

    super.onInit();
  }
}
