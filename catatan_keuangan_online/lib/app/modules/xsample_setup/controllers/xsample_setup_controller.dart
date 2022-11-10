import 'dart:convert';

import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../models/text_model.dart';

class XsampleSetupController extends GetxController {
  late SetupPageController formCon;
  final nameCon = InputTextController();

  @override
  void onInit() {
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/test/$id',
      urlApiPost: () => '/api/test',
      urlApiPut: (id) => '/api/test/$id',
      urlApiDelete: (id) => '/api/test/$id',
      bodyApi: (id) => {
        'name': nameCon.value,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!nameCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        TestModel model = TestModel.fromJson(json);
        nameCon.value = model.name;
      },
      onInit: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
    );

    super.onInit();
  }
}
