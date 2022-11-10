import 'dart:convert';

class TestModel {
  int? id;
  String? name;

  TestModel();

  TestModel.init(this.id, this.name);

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static TestModel fromDynamic(dynamic dynamicData) {
    final model = TestModel();
    model.id = dynamicData['id'];
    model.name = dynamicData['name'];
    return model;
  }
}

class TestQtyModel {
  int? id;
  String? nama;
  int? qty;

  TestQtyModel();
  TestQtyModel.init(this.id, this.nama, this.qty);

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static TestQtyModel fromDynamic(dynamic dynamicData) {
    final model = TestQtyModel();
    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.qty = dynamicData['qty'];
    return model;
  }
}
