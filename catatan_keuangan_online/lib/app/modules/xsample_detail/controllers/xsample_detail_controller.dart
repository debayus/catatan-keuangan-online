import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_detail_component.dart';
import '../../../mahas/components/inputs/input_detail_setup_component.dart';
import '../../../mahas/components/inputs/input_detail_setup_list_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/services/helper.dart';
import '../../../models/text_model.dart';

class XsampleDetailController extends GetxController {
  var editable = true.obs;

  // simple detail
  final detailCon = InputDetailControler<TestModel>(
    itemKey: (e) => e.id,
    fromDynamic: (e) => TestModel.fromDynamic(e),
    itemText: (e) => e.name ?? "",
    urlApi: (index, filter) => '/api/test?page=$index&filter=$filter',
  );

  // setup detail
  late InputDetailSetupControler<TestModel> detailSetupCon;

  // setup list detail
  late InputDetailSetupListControler<TestModel, TestQtyModel>
      detailSetupListCon;

  // input detail
  final detailInputTextCon = InputTextController();
  final detailInputQtyCon = InputTextController(
    type: InputTextType.number,
  );

  void changeEditableOnPress() {
    editable.value = !editable.value;
    editable.refresh();
  }

  void validateOnPress() {
    // simple detail
    detailCon.isValid;

    // setup detail
    detailSetupCon.isValid;

    // setup list detail
    detailSetupListCon.isValid;
  }

  void setValueOnPress() {
    // simple detail
    detailCon.clear();
    detailCon.addValue(TestModel.init(1, "Data 1"));
    detailCon.addValue(TestModel.init(2, "Data 2"));

    // setup detail
    detailSetupCon.clear();
    detailSetupCon.addValue(TestModel.init(1, "Data 1"));
    detailSetupCon.addValue(TestModel.init(2, "Data 2"));

    // setup list detail
    detailSetupListCon.clear();
    detailSetupListCon.addValue(TestQtyModel.init(1, "Data 1", 10));
    detailSetupListCon.addValue(TestQtyModel.init(2, "Data 2", 19));
  }

  void getValueOnPress() {
    // simple detail
    var val = 'Simple Detail\n';
    for (var e in detailCon.values) {
      val += '${e.id} - ${e.name}\n';
    }

    // setup detail
    val += '\n\nSetup Detail\n';
    for (var e in detailSetupCon.values) {
      val += '${e.value.id} - ${e.value.name}\n';
    }

    // setup list detail
    val += '\n\nSetup List Detail\n';
    for (var e in detailSetupListCon.values) {
      val += '${e.id} - ${e.nama} - ${e.qty}\n';
    }

    Helper.dialogWarning(val);
  }

  void updateValueOnPress() {
    // simple detail
    for (var e in detailCon.values) {
      e.name = 'Updated';
      detailCon.updateValue(e.id, e);
    }

    // setup detail
    for (var e in detailSetupCon.values) {
      e.value.name = 'Updated';
      detailSetupCon.updateValue(e.key, e.value);
    }

    // setup list detail
    for (var e in detailSetupListCon.values) {
      e.nama = 'Updated';
      detailSetupListCon.updateValue(e.id, e);
    }
  }

  @override
  void onInit() {
    super.onInit();

    // setup detail
    detailSetupCon = InputDetailSetupControler<TestModel>(
      itemKey: (e) => e.id,
      fromDynamic: (e) => TestModel.fromDynamic(e),
      itemText: (e) => e.name ?? "",
      onOpenForm: (id, e) {
        detailInputTextCon.value = e?.name;
      },
      onFormInsert: (id) {
        if (!detailInputTextCon.isValid) return null;
        var r = TestModel();
        r.id = id;
        r.name = detailInputTextCon.value;
        return r;
      },
    );

    // setup list detail
    detailSetupListCon = InputDetailSetupListControler<TestModel, TestQtyModel>(
      urlApi: (index, filter) => '/api/test?page=$index&filter=$filter',
      itemKey: (e) => e.id,
      itemKeyU: (e) => e.id,
      fromDynamic: (e) => TestModel.fromDynamic(e),
      itemText: (e) => e.name ?? "",
      itemTextU: (e) => e.nama ?? "",
      onOpenForm: (e) {
        detailInputTextCon.value = e.name;
        detailInputQtyCon.value = 1;
      },
      onOpenFormEdit: (e) {
        detailInputTextCon.value = e.nama;
        detailInputQtyCon.value = e.qty;
      },
      onFormInsert: (e) {
        if (!detailInputTextCon.isValid) return null;
        if (!detailInputQtyCon.isValid) return null;
        var r = TestQtyModel();
        r.id = e.id;
        r.nama = detailInputTextCon.value;
        r.qty = detailInputQtyCon.value;
        return r;
      },
      onFormUpdate: (e) {
        if (!detailInputTextCon.isValid) return null;
        if (!detailInputQtyCon.isValid) return null;
        e.nama = detailInputTextCon.value;
        e.qty = detailInputQtyCon.value;
        return e;
      },
      // readd: (oldModel, newModel) {
      //   oldModel.nama = newModel.nama;
      //   oldModel.qty = (oldModel.qty ?? 0) + (newModel.qty ?? 0);
      //   return oldModel;
      // },
    );
  }
}
