import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../controllers/xsample_date_time_controller.dart';

class XsampleDateTimeView extends GetView<XsampleDateTimeController> {
  const XsampleDateTimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDatetimeComponent(
                  controller: controller.dateCon,
                  editable: controller.editable.value,
                  required: true,
                  label: 'Date',
                ),
                InputDatetimeComponent(
                  controller: controller.timeCon,
                  editable: controller.editable.value,
                  required: true,
                  label: 'Time',
                  type: InputDatetimeType.time,
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
