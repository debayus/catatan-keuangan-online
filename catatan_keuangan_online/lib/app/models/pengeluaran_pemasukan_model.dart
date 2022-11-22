import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class PengeluaranPemasukanModel {
  int? id;
  int? idUser;
  int? idJenisPengeluaranPemasukan;
  int? idRekening;
  DateTime? tanggal;
  double? nilai;
  String? catatan;
  bool? pengeluaran;
  String? idUserNama;
  String? idJenisPengeluaranPemasukanNama;
  String? idRekeningNama;

  static PengeluaranPemasukanModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static PengeluaranPemasukanModel fromDynamic(dynamic dynamicData) {
    final model = PengeluaranPemasukanModel();
    model.id = dynamicData['id'];
    model.idUser = MahasFormat.dynamicToInt(dynamicData['id_user']);
    model.idJenisPengeluaranPemasukan =
        MahasFormat.dynamicToInt(dynamicData['id_jenis_pengeluaran_pemasukan']);
    model.idRekening = MahasFormat.dynamicToInt(dynamicData['id_rekening']);
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    model.catatan = dynamicData['catatan'];
    model.pengeluaran = MahasFormat.dynamicToBool(dynamicData['pengeluaran']);
    model.idUserNama = dynamicData['id_user_nama'];
    model.idJenisPengeluaranPemasukanNama =
        dynamicData['id_jenis_pengeluaran_pemasukan_nama'];
    model.idRekeningNama = dynamicData['id_rekening_nama'];
    model.pengeluaran = MahasFormat.dynamicToBool(dynamicData['pengeluaran']);
    return model;
  }
}
