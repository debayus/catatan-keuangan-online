import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class GrafikPieItemModel {
  int? id;
  String? nama;
  double? nilai;

  static GrafikPieItemModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static GrafikPieItemModel fromDynamic(dynamic dynamicData) {
    final model = GrafikPieItemModel();
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    return model;
  }
}

class GrafikLineItemModel {
  int? id;
  DateTime? tanggal;
  double? nilai;

  static GrafikLineItemModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static GrafikLineItemModel fromDynamic(dynamic dynamicData) {
    final model = GrafikLineItemModel();
    model.id = dynamicData['id'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['tanggal']);
    model.nilai = MahasFormat.dynamicToDouble(dynamicData['nilai']);
    return model;
  }
}
