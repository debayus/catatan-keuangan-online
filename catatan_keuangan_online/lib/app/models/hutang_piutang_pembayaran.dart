import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class HutangPiutangPembayaranModel {
  int? id;
  int? idRekening;
  DateTime? tanggal;
  double? nilai;
  String? catatan;
  String? idRekeningNama;

  static HutangPiutangPembayaranModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static HutangPiutangPembayaranModel fromDynamic(dynamic dynamicData) {
    final model = HutangPiutangPembayaranModel();
    model.id = dynamicData['id'];
    model.idRekening = dynamicData['id_rekening'];
    model.idRekeningNama = dynamicData['id_rekening_nama'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    model.catatan = dynamicData['catatan'];
    return model;
  }
}
