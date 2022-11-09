import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_checkbox_component.dart';
import '../../../mahas/components/inputs/input_checkbox_multiple_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../controllers/xsample_checkbox_radio_controller.dart';

class XsampleCheckboxRadioView extends GetView<XsampleCheckboxRadioController> {
  const XsampleCheckboxRadioView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox & Radio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputCheckboxComponent(
                  controller: controller.checkboxCon,
                  editable: controller.editable.value,
                  label: 'Checkbox',
                ),
                InputCheckboxComponent(
                  controller: controller.switchCon,
                  editable: controller.editable.value,
                  isSwitch: true,
                  label: 'Switch',
                ),
                InputRadioComponent(
                  controller: controller.radioCon,
                  editable: controller.editable.value,
                  required: true,
                  label: 'Radio',
                ),
                InputCheckboxMultipleComponent(
                  controller: controller.checkboxMultipleCon,
                  editable: controller.editable.value,
                  label: 'Checkbox Multiple',
                ),
                ElevatedButton(
                  onPressed: controller.validateOnPress,
                  child: const Text("Validate"),
                ),
                ElevatedButton(
                  onPressed: controller.changeEditableOnPress,
                  child: const Text("Change Editable"),
                ),
                ElevatedButton(
                  onPressed: controller.setValueOnPress,
                  child: const Text("Set Value"),
                ),
                ElevatedButton(
                  onPressed: controller.getValueOnPress,
                  child: const Text("Get Value"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
