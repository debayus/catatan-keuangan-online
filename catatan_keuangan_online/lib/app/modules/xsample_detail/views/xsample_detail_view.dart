import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_detail_component.dart';
import '../../../mahas/components/inputs/input_detail_setup_component.dart';
import '../../../mahas/components/inputs/input_detail_setup_list_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../models/text_model.dart';
import '../controllers/xsample_detail_controller.dart';

class XsampleDetailView extends GetView<XsampleDetailController> {
  const XsampleDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              InputDetailComponent<TestModel>(
                label: "Simple Detail",
                controller: controller.detailCon,
                editable: controller.editable.value,
                required: true,
                // builder: (e, editable, deleteOnPress) => Container(
                //   child: Column(
                //     children: [
                //       Text(e.nama ?? ""),
                //       InkWell(
                //         onTap: deleteOnPress,
                //         child: Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
              InputDetailSetupComponent<TestModel>(
                label: "Setup Detail",
                controller: controller.detailSetupCon,
                editable: controller.editable.value,
                required: true,
                formBuilder: (e) => Column(
                  children: [
                    // form detail
                    InputTextComponent(
                      controller: controller.detailInputTextCon,
                      label: "Nama",
                      required: true,
                    ),
                  ],
                ),
                // builder: (e, editable, deleteOnPress, editOnPress) => Container(
                //   child: Column(
                //     children: [
                //       Text(e.nama ?? ""),
                //       InkWell(
                //         onTap: deleteOnPress,
                //         child: Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //       ),
                //       InkWell(
                //         onTap: editOnPress,
                //         child: Icon(
                //           Icons.edit,
                //           color: Colors.red,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
              InputDetailSetupListComponent<TestModel, TestQtyModel>(
                label: "Setup List Detail",
                controller: controller.detailSetupListCon,
                editable: controller.editable.value,
                required: true,
                formBuilder: (e) => Column(
                  children: [
                    // form detail
                    InputTextComponent(
                      controller: controller.detailInputTextCon,
                      label: "Nama",
                      required: true,
                    ),
                    InputTextComponent(
                      controller: controller.detailInputQtyCon,
                      label: "Qty",
                      required: true,
                    ),
                  ],
                ),
                builder: (e, editable, deleteOnPress, editOnPress) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(e.nama ?? ""),
                          Expanded(child: Container()),
                          Visibility(
                            visible: editable,
                            child: InkWell(
                              onTap: deleteOnPress,
                              child: const Icon(
                                Icons.delete_forever,
                                color: MahasColors.danger,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Qty : ${e.qty}",
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      InkWell(
                        onTap: editOnPress,
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: MahasColors.primary),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                      onPressed: controller.updateValueOnPress,
                      child: const Text("Update Value"),
                    ),
                    ElevatedButton(
                      onPressed: controller.getValueOnPress,
                      child: const Text("Get Value"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
