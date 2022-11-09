import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/services/helper.dart';

class XsampleDateTimeController extends GetxController {
  var editable = true.obs;

  final dateCon = InputDatetimeController();
  final timeCon = InputDatetimeController();

  void changeEditableOnPress() {
    editable.value = !editable.value;
    editable.refresh();
  }

  void validateOnPress() {
    dateCon.isValid;
    timeCon.isValid;
  }

  void setValueOnPress() {
    dateCon.value = MahasFormat.stringToDate('2021-01-01');
    timeCon.value = MahasFormat.stringToTime('11:24');
  }

  void getValueOnPress() {
    var val = '''
${MahasFormat.displayDate(dateCon.value)}
${MahasFormat.displayTime(timeCon.value)}
''';
    Helper.dialogWarning(val);
  }
}
