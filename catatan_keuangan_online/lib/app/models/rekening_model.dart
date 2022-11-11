import 'dart:convert';

import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class RekeningModel {
  int? id;
  String? nama;
  String? icon;
  double? saldo;

  static RekeningModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static RekeningModel fromDynamic(dynamic dynamicData) {
    final model = RekeningModel();
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.icon = dynamicData['icon'];
    model.saldo = MahasFormat.dynamicToDouble(dynamicData['saldo']);
    return model;
  }
}
