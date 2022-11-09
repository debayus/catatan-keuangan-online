import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_dropdown_component.dart';
import '../controllers/xsample_dropdown_controller.dart';

class XsampleDropdownView extends GetView<XsampleDropdownController> {
  const XsampleDropdownView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drop down'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDropdownComponent(
                  controller: controller.dropdownCon,
                  editable: controller.editable.value,
                  required: true,
                  label: 'Drop Down',
                ),
                // InputLookupComponent<TestModel>(
                //   controller: controller.lookupCon,
                //   editable: controller.editable.value,
                //   required: true,
                //   label: 'Lookup',
                // ),
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
