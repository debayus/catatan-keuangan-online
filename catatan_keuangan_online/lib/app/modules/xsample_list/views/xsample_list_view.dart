import 'package:catatan_keuangan_online/app/mahas/components/others/list_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../models/text_model.dart';
import '../controllers/xsample_list_controller.dart';

class XsampleListView extends GetView<XsampleListController> {
  const XsampleListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: controller.addOnPress,
              child: const Icon(
                FontAwesomeIcons.plus,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (TestModel e) {
          return ListTile(
            title: Text(e.name!),
            onTap: () => controller.itemOnTab(e.id!),
          );
        },
      ),
    );
  }
}
