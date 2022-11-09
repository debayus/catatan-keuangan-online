import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_controller.dart';

class XsampleView extends GetView<XsampleController> {
  const XsampleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title: Text(controller.menus[i].title),
          leading: Icon(controller.menus[i].icon),
          onTap: controller.menus[i].onTab,
        ),
        itemCount: controller.menus.length,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
      ),
    );
  }
}
