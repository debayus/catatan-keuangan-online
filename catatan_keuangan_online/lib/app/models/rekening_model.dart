import 'dart:convert';

class RekeningModel {
  String? nama;
  String? icon;
  double? saldo;

  static RekeningModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static RekeningModel fromDynamic(dynamic dynamicData) {
    final model = RekeningModel();

    model.nama = dynamicData['nama'];
    model.icon = dynamicData['icon'];
    model.saldo = dynamicData['saldo'];
    return model;
  }
}
