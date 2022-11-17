import 'dart:convert';

class ProfileModel {
  String? perusahaan;
  int? id;
  String? nama;
  bool? superUser;
  int? idPerusahaanUser;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.idPerusahaanUser = dynamicData['id_perusahaan_user'];
    model.perusahaan = dynamicData['perusahaan'];
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.superUser = dynamicData['super_user'];
    return model;
  }
}
