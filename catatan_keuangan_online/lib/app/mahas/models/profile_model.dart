import 'dart:convert';

class ProfileModel {
  String? perusahaan;
  String? nama;
  bool? superUser;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.perusahaan = dynamicData['perusahaan'];
    model.nama = dynamicData['nama'];
    model.superUser = dynamicData['super_user'];
    return model;
  }
}
