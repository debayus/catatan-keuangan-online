import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_checkbox_component.dart';
import '../../../mahas/components/inputs/input_checkbox_multiple_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/services/helper.dart';

class XsampleCheckboxRadioController extends GetxController {
  var editable = true.obs;

  final checkboxCon = InputCheckboxController();
  final switchCon = InputCheckboxController();
  final radioCon = InputRadioController(
    items: [
      RadioButtonItem.simple("Radio 1"),
      RadioButtonItem.simple("Radio 2"),
    ],
  );
  final checkboxMultipleCon = InputCheckboxMultipleController(
    items: [
      CheckboxMultipleItem.simple("Check 1"),
      CheckboxMultipleItem.simple("Check 2"),
    ],
  );

  void changeEditableOnPress() {
    editable.value = !editable.value;
    editable.refresh();
  }

  void validateOnPress() {
    radioCon.isValid;
  }

  void setValueOnPress() {
    checkboxCon.checked = true;
    switchCon.checked = true;
    radioCon.value = 'Radio 2';
    for (var e in checkboxMultipleCon.items) {
      e.checked = true;
    }
    checkboxMultipleCon.refresh();
  }

  void getValueOnPress() {
    var val = '''
${checkboxCon.checked}
${switchCon.checked}
${radioCon.value}
${checkboxMultipleCon.items.map((e) => e.checked).join('\n')}
''';
    Helper.dialogWarning(val);
  }
}
