import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class TransaksiModel {
  int? id;
  int? idRekening;
  DateTime? tanggal;
  double? nilai;
  String? catatan;
  String? jenis;
  String? tipe;
  String? rekeningsNama;

  static TransaksiModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static TransaksiModel fromDynamic(dynamic dynamicData) {
    final model = TransaksiModel();
    model.id = dynamicData['id'];
    model.idRekening = dynamicData['id_rekening'];
    model.catatan = dynamicData['catatan'];
    model.jenis = dynamicData['jenis'];
    model.tipe = dynamicData['tipe'];
    model.rekeningsNama = dynamicData['rekenings_nama'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    return model;
  }
}
