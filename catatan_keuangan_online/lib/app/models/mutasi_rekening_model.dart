import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class MutasiRekeningModel {
  int? id;
  int? idRekeningDari;
  int? idRekeningTujuan;
  DateTime? tanggal;
  double? nilai;
  String? catatan;
  String? idRekeningDariNama;
  String? idRekeningTujuanNama;

  static MutasiRekeningModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static MutasiRekeningModel fromDynamic(dynamic dynamicData) {
    final model = MutasiRekeningModel();
    model.id = dynamicData['id'];
    model.idRekeningDari = dynamicData['id_rekening_dari'];
    model.idRekeningTujuan = dynamicData['id_rekening_tujuan'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    model.catatan = dynamicData['catatan'];
    model.idRekeningDariNama = dynamicData['id_rekening_dari_nama'];
    model.idRekeningTujuanNama = dynamicData['id_rekening_tujuan_nama'];
    return model;
  }
}
