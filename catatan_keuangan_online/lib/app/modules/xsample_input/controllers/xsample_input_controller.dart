import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/services/helper.dart';

class XsampleInputController extends GetxController {
  var editable = true.obs;

  final inputTextCon = InputTextController();
  final inputEmailCon = InputTextController(
    type: InputTextType.email,
  );
  final inputNumberCon = InputTextController(
    type: InputTextType.number,
  );
  final inputMoneyCon = InputTextController(
    type: InputTextType.money,
  );
  final inputParagrafCon = InputTextController(
    type: InputTextType.paragraf,
  );
  final inputPasswordCon = InputTextController(
    type: InputTextType.password,
  );

  void changeEditableOnPress() {
    editable.value = !editable.value;
    editable.refresh();
  }

  void validateOnPress() {
    inputTextCon.isValid;
    inputEmailCon.isValid;
    inputNumberCon.isValid;
    inputMoneyCon.isValid;
    inputParagrafCon.isValid;
    inputPasswordCon.isValid;
  }

  void setValueOnPress() {
    inputTextCon.value = "Test";
    inputEmailCon.value = "test@test.test";
    inputNumberCon.value = 123456;
    inputMoneyCon.value = 100000;
    inputParagrafCon.value = "Test\nTest";
    inputPasswordCon.value = "123456";
  }

  void getValueOnPress() {
    var val = '''
${inputTextCon.value}
${inputEmailCon.value}
${inputNumberCon.value}
${inputMoneyCon.value}
${inputParagrafCon.value}
${inputPasswordCon.value}
''';
    Helper.dialogWarning(val);
  }
}
