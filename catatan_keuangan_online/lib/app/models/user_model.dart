import 'dart:convert';

import '../mahas/services/mahas_format.dart';

class UserModel {
  int? id;
  String? nama;
  String? email;
  String? idFirebase;
  bool? superUser;

  UserModel();
  UserModel.init(this.id, this.nama);

  static UserModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static UserModel fromDynamic(dynamic dynamicData) {
    final model = UserModel();
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.idFirebase = dynamicData['id_firebase'];
    model.email = dynamicData['email'];
    model.superUser = MahasFormat.dynamicToBool(dynamicData['super_user']);
    return model;
  }
}
