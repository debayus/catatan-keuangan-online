import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_setup_controller.dart';

class XsampleSetupView extends GetView<XsampleSetupController> {
  const XsampleSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XsampleSetupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'XsampleSetupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
