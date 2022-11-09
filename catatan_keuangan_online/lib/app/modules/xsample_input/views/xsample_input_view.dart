import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../controllers/xsample_input_controller.dart';

class XsampleInputView extends GetView<XsampleInputController> {
  const XsampleInputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputTextComponent(
                  label: "Text",
                  controller: controller.inputTextCon,
                  editable: controller.editable.value,
                  required: true,
                ),
                InputTextComponent(
                  label: "Email",
                  controller: controller.inputEmailCon,
                  editable: controller.editable.value,
                  required: true,
                ),
                InputTextComponent(
                  label: "Money",
                  controller: controller.inputMoneyCon,
                  editable: controller.editable.value,
                  required: true,
                ),
                InputTextComponent(
                  label: "Number",
                  controller: controller.inputNumberCon,
                  editable: controller.editable.value,
                  required: true,
                ),
                InputTextComponent(
                  label: "paragraf",
                  controller: controller.inputParagrafCon,
                  editable: controller.editable.value,
                  required: true,
                ),
                InputTextComponent(
                  label: "Password",
                  controller: controller.inputPasswordCon,
                  editable: controller.editable.value,
                  required: true,
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
