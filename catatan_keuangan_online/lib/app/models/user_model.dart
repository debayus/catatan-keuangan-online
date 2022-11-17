import 'dart:convert';

class UserModel {
  int? id;
  String? nama;
  String? email;
  String? idFirebase;

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
    return model;
  }
}
