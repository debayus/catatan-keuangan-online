import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/models/user_model.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_checkbox_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';

class PengaturanUserSetupController extends GetxController {
  late SetupPageController formCon;
  final namaCon = InputTextController();
  final emailCon = InputTextController();
  final tokenCon = InputTextController();
  final superUserCon = InputCheckboxController();

  @override
  void onInit() {
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/user/$id',
      urlApiPost: () => '/api/user',
      urlApiPut: (id) => '/api/user/$id',
      urlApiDelete: (id) => '/api/user/$id',
      bodyApi: (id) => {
        'nama': namaCon.value,
        'email': emailCon.value,
        'id_firebase': tokenCon.value,
        'input_super_user': superUserCon.checked ? 1 : 0,
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        if (!namaCon.isValid) return false;
        if (!emailCon.isValid) return false;
        if (!tokenCon.isValid) return false;
        return true;
      },
      apiToView: (json) {
        var model = UserModel.fromJson(json);
        namaCon.value = model.nama;
        emailCon.value = model.email;
        tokenCon.value = model.idFirebase;
        superUserCon.checked = model.superUser!;
      },
      allowDelete: MahasConfig.profile?.superUser == true,
      allowEdit: MahasConfig.profile?.superUser == true,
    );

    super.onInit();
  }
}
