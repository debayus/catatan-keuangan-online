import 'dart:convert';

import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';

class ProfileModel {
  String? perusahaan;
  int? id;
  String? nama;
  bool? superUser;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.perusahaan = dynamicData['perusahaan'];
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.superUser = MahasFormat.dynamicToBool(dynamicData['super_user']);
    return model;
  }
}
