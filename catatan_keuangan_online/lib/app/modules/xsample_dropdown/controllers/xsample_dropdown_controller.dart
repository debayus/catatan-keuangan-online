import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_dropdown_component.dart';
import '../../../mahas/services/helper.dart';

class XsampleDropdownController extends GetxController {
  var editable = true.obs;

  final dropdownCon = InputDropdownController(
    items: [
      DropdownItem.simple("Option 1"),
      DropdownItem.simple("Option 2"),
      DropdownItem.simple("Option 3"),
      DropdownItem.init("Text 4", "Option 4"),
    ],
  );

  // final lookupCon = InputLookupController<TestModel>(
  //   urlApi: (pageIndex, filter) => '/api/test?page=$pageIndex&filter=$filter',
  //   fromDynamic: TestModel.fromDynamic,
  //   itemText: (e) => e.nama ?? "",
  //   itemValue: (e) => e.id,
  //   // custom widget
  //   // itemBuilder: (e, onClick, color) => ListTile(
  //   //   tileColor: color,
  //   //   title: TextComponent(e.nama ?? ""),
  //   //   trailing: Icon(Icons.rocket),
  //   //   onTap: onClick,
  //   // ),
  // );

  void changeEditableOnPress() {
    editable.value = !editable.value;
    editable.refresh();
  }

  void validateOnPress() {
    dropdownCon.isValid;
    // lookupCon.isValid;
  }

  void setValueOnPress() {
    dropdownCon.value = "Option 4";
    // lookupCon.value = TestModel.init(1, 'Test 0');
  }

  void getValueOnPress() {
    var val = '''
${dropdownCon.value} - ${dropdownCon.text}
''';
// ${lookupCon.value?.id} - ${lookupCon.value?.nama}

    Helper.dialogWarning(val);
  }
}
