import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_detail_controller.dart';

class XsampleDetailView extends GetView<XsampleDetailController> {
  const XsampleDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XsampleDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'XsampleDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
