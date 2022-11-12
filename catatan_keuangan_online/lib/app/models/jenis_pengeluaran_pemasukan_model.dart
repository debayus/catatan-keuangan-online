import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class JenisPengeluaranPemasukanModel {
  int? id;
  String? nama;
  String? icon;
  bool? pengeluaran;

  static JenisPengeluaranPemasukanModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static JenisPengeluaranPemasukanModel fromDynamic(dynamic dynamicData) {
    final model = JenisPengeluaranPemasukanModel();
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.icon = dynamicData['icon'];
    model.pengeluaran = MahasFormat.dynamicToBool(dynamicData['pengeluaran']);
    return model;
  }
}
