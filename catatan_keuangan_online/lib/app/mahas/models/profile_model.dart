import 'dart:convert';

class ProfileModel {
  int? id;
  String? nama;
  bool superUser = false;
  bool kelolaPengeluaran = false;
  bool kelolaPemasukan = false;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.superUser = dynamicData['superUser'];
    model.kelolaPengeluaran = dynamicData['kelolaPengeluaran'];
    model.kelolaPemasukan = dynamicData['kelolaPemasukan'];
    return model;
  }
}
