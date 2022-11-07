import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({
    Key? key,
    PengaturanController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
