import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class HutangPiutangModel {
  int? id;
  int? idRekening;
  DateTime? tanggal;
  DateTime? tanggalTempo;
  double? nilai;
  double? dibayar;
  String? catatan;
  bool? hutang;
  String? idRekeningNama;

  static HutangPiutangModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static HutangPiutangModel fromDynamic(dynamic dynamicData) {
    final model = HutangPiutangModel();
    model.id = dynamicData['id'];
    model.idRekening = dynamicData['id_rekening'];
    model.idRekeningNama = dynamicData['id_rekening_nama'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.tanggalTempo =
        MahasFormat.dynamicToDateTime(dynamicData['tanggal_tempo']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    model.dibayar = MahasFormat.dynamicToDouble(dynamicData['dibayar']);
    model.catatan = dynamicData['catatan'];
    model.hutang = MahasFormat.dynamicToBool(dynamicData['hutang']);
    return model;
  }
}
