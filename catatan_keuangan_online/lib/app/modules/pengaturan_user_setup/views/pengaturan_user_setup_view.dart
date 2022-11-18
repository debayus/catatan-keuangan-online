import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_checkbox_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/pengaturan_user_setup_controller.dart';

class PengaturanUserSetupView extends GetView<PengaturanUserSetupController> {
  const PengaturanUserSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'User',
      children: () => [
        InputTextComponent(
          label: 'Nama',
          controller: controller.namaCon,
          required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Email',
          controller: controller.emailCon,
          required: true,
          editable: controller.formCon.editable,
        ),
        InputCheckboxComponent(
          controller: controller.superUserCon,
          editable: controller.formCon.editable,
          label: 'Super User',
        ),
      ],
    );
  }
}
