import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/xsample_setup_controller.dart';

class XsampleSetupView extends GetView<XsampleSetupController> {
  const XsampleSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Setup',
      children: () => [
        InputTextComponent(
          label: 'Nama',
          controller: controller.nameCon,
          required: true,
          editable: controller.formCon.editable,
        ),
      ],
    );
  }
}
