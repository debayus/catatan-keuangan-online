import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_list_controller.dart';

class XsampleListView extends GetView<XsampleListController> {
  const XsampleListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XsampleListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'XsampleListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
